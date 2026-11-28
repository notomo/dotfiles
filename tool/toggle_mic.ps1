# Toggle enabled/disabled of a specific recording device.
# (Not mute: some USB devices like Logitech C920 stay silent after mute -> unmute until replugged.)
#   toggle_mic.ps1 -List             : list recording devices
#   toggle_mic.ps1 -Name "*Realtek*" : toggle matched device(s)
#   -NoNotify                         : do not show toast notification
param(
  [string]$Name,
  [switch]$List,
  [switch]$NoNotify
)

Add-Type -TypeDefinition @'
using System;
using System.Collections.Generic;
using System.Runtime.InteropServices;

namespace MicToggle {
  [StructLayout(LayoutKind.Sequential)]
  struct PropertyKey { public Guid fmtid; public int pid; }

  [StructLayout(LayoutKind.Sequential)]
  struct PropVariant { public ushort vt; public ushort r1, r2, r3; public IntPtr p1; public IntPtr p2; }

  [ComImport, Guid("886d8eeb-8cf2-4446-8d02-cdba1dbdcf99"), InterfaceType(ComInterfaceType.InterfaceIsIUnknown)]
  interface IPropertyStore {
    int GetCount(out int c);
    int GetAt(int i, out PropertyKey k);
    int GetValue(ref PropertyKey k, out PropVariant v);
  }

  [ComImport, Guid("D666063F-1587-4E43-81F1-B948E807363F"), InterfaceType(ComInterfaceType.InterfaceIsIUnknown)]
  interface IMMDevice {
    int Activate(ref Guid iid, int ctx, IntPtr p, [MarshalAs(UnmanagedType.IUnknown)] out object o);
    int OpenPropertyStore(int access, out IPropertyStore s);
    int GetId([MarshalAs(UnmanagedType.LPWStr)] out string id);
    int GetState(out int state);
  }

  [ComImport, Guid("0BD7A1BE-7A1A-44DB-8397-CC5392387B5E"), InterfaceType(ComInterfaceType.InterfaceIsIUnknown)]
  interface IMMDeviceCollection {
    int GetCount(out int c);
    int Item(int i, out IMMDevice d);
  }

  [ComImport, Guid("A95664D2-9614-4F35-A746-DE8DB63617E6"), InterfaceType(ComInterfaceType.InterfaceIsIUnknown)]
  interface IMMDeviceEnumerator {
    int EnumAudioEndpoints(int flow, int mask, out IMMDeviceCollection c);
    int GetDefaultAudioEndpoint(int flow, int role, out IMMDevice d);
  }

  [ComImport, Guid("BCDE0395-E52F-467C-8E3D-C4579291692E")]
  class MMDeviceEnumerator {}

  // undocumented, but widely used to change endpoint visibility and default device
  [ComImport, Guid("f8679f50-850a-41cf-9c72-430f290290c8"), InterfaceType(ComInterfaceType.InterfaceIsIUnknown)]
  interface IPolicyConfig {
    int f1(); int f2(); int f3(); int f4(); int f5();
    int f6(); int f7(); int f8(); int f9(); int f10();
    int SetDefaultEndpoint([MarshalAs(UnmanagedType.LPWStr)] string id, int role);
    int SetEndpointVisibility([MarshalAs(UnmanagedType.LPWStr)] string id, int visible);
  }

  [ComImport, Guid("870af99c-171d-4f9e-af0d-e63df40c2bc9")]
  class PolicyConfigClient {}

  public class Mic {
    const int eCapture = 1;
    const int DEVICE_STATE_ACTIVE = 1;
    const int DEVICE_STATE_DISABLED = 2;

    public string Name;
    public string Id;
    public bool Enabled;

    public void SetEnabled(bool enabled) {
      var p = (IPolicyConfig)new PolicyConfigClient();
      Marshal.ThrowExceptionForHR(p.SetEndpointVisibility(Id, enabled ? 1 : 0));
      Enabled = enabled;
    }

    // role: 0=console, 1=multimedia, 2=communications
    public void SetDefault(int role) {
      var p = (IPolicyConfig)new PolicyConfigClient();
      Marshal.ThrowExceptionForHR(p.SetDefaultEndpoint(Id, role));
    }

    public static string GetDefaultId(int role) {
      var en = (IMMDeviceEnumerator)new MMDeviceEnumerator();
      IMMDevice d;
      if (en.GetDefaultAudioEndpoint(eCapture, role, out d) != 0) return null;
      string id;
      d.GetId(out id);
      return id;
    }

    public static List<Mic> GetAll() {
      var list = new List<Mic>();
      var en = (IMMDeviceEnumerator)new MMDeviceEnumerator();
      IMMDeviceCollection col;
      Marshal.ThrowExceptionForHR(en.EnumAudioEndpoints(eCapture, DEVICE_STATE_ACTIVE | DEVICE_STATE_DISABLED, out col));
      int n;
      col.GetCount(out n);
      for (int i = 0; i < n; i++) {
        IMMDevice d;
        col.Item(i, out d);
        IPropertyStore ps;
        d.OpenPropertyStore(0, out ps);
        var key = new PropertyKey { fmtid = new Guid("a45c254e-df1c-4efd-8020-67d146a850e0"), pid = 14 };
        PropVariant v;
        ps.GetValue(ref key, out v);
        string id;
        d.GetId(out id);
        int state;
        d.GetState(out state);
        list.Add(new Mic {
          Name = v.vt == 31 ? Marshal.PtrToStringUni(v.p1) : id,
          Id = id,
          Enabled = state == DEVICE_STATE_ACTIVE,
        });
      }
      return list;
    }
  }
}
'@

$mics = [MicToggle.Mic]::GetAll()

if ($List -or -not $Name) {
  $mics | ForEach-Object { '{0}  (enabled: {1})' -f $_.Name, $_.Enabled }
  return
}

$targets = @($mics | Where-Object { $_.Name -like $Name })
if ($targets.Count -eq 0) {
  Write-Error "device not found: $Name"
  exit 1
}

# Disabling a default device makes Windows pick another one,
# so remember the default roles here and restore them on enable.
$defaultsPath = Join-Path $env:TEMP 'toggle_mic_defaults.txt'
$roles = 0, 1, 2

$enabled = -not $targets[0].Enabled
if ($enabled) {
  $saved = if (Test-Path $defaultsPath) { @(Get-Content $defaultsPath) } else { @() }
  foreach ($m in $targets) {
    $m.SetEnabled($true)
    foreach ($line in $saved) {
      $role, $id = $line -split ' ', 2
      if ($id -eq $m.Id) { $m.SetDefault([int]$role) }
    }
  }
  Remove-Item $defaultsPath -ErrorAction SilentlyContinue
} else {
  $ids = $targets | ForEach-Object { $_.Id }
  $saved = foreach ($role in $roles) {
    $id = [MicToggle.Mic]::GetDefaultId($role)
    if ($ids -contains $id) { "$role $id" }
  }
  Set-Content -Path $defaultsPath -Value $saved
  foreach ($m in $targets) { $m.SetEnabled($false) }
}

if ($NoNotify) { return }

# feedback: toast notification (replaces previous one via Tag/Group)
[Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime] | Out-Null
[Windows.Data.Xml.Dom.XmlDocument, Windows.Data.Xml.Dom.XmlDocument, ContentType = WindowsRuntime] | Out-Null

$emoji = if ($enabled) { [char]::ConvertFromUtf32(0x1F3A4) } else { [char]::ConvertFromUtf32(0x1F507) } # microphone / speaker with cancellation stroke
$title = if ($enabled) { "$emoji Mic enabled" } else { "$emoji Mic disabled" }
$body = [System.Security.SecurityElement]::Escape(($targets | ForEach-Object { $_.Name }) -join ', ')

function New-MicIcon([bool]$Enabled, [string]$Path) {
  Add-Type -AssemblyName System.Drawing
  $bmp = New-Object System.Drawing.Bitmap 96, 96
  $g = [System.Drawing.Graphics]::FromImage($bmp)
  $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias

  $bg = if ($Enabled) { [System.Drawing.Color]::FromArgb(40, 167, 69) } else { [System.Drawing.Color]::FromArgb(220, 53, 69) }
  $brush = New-Object System.Drawing.SolidBrush $bg
  $g.FillEllipse($brush, 0, 0, 95, 95)

  $white = [System.Drawing.Color]::White
  $round = [System.Drawing.Drawing2D.LineCap]::Round

  # capsule
  $capsule = New-Object System.Drawing.Pen $white, 22
  $capsule.StartCap = $round
  $capsule.EndCap = $round
  $g.DrawLine($capsule, 48, 30, 48, 44)

  # holder, stem and base
  $line = New-Object System.Drawing.Pen $white, 6
  $line.StartCap = $round
  $line.EndCap = $round
  $g.DrawArc($line, 28, 30, 40, 34, 0, 180)
  $g.DrawLine($line, 48, 64, 48, 74)
  $g.DrawLine($line, 38, 76, 58, 76)

  if (-not $Enabled) {
    $gap = New-Object System.Drawing.Pen $bg, 14
    $gap.StartCap = $round
    $gap.EndCap = $round
    $g.DrawLine($gap, 26, 22, 70, 74)
    $slash = New-Object System.Drawing.Pen $white, 7
    $slash.StartCap = $round
    $slash.EndCap = $round
    $g.DrawLine($slash, 26, 22, 70, 74)
  }

  $g.Dispose()
  $bmp.Save($Path, [System.Drawing.Imaging.ImageFormat]::Png)
  $bmp.Dispose()
}

$iconPath = Join-Path $env:TEMP ('toggle_mic_{0}.png' -f $(if ($enabled) { 'enabled' } else { 'disabled' }))
New-MicIcon $enabled $iconPath
$iconUri = ([Uri]$iconPath).AbsoluteUri

$sound = if ($enabled) { 'ms-winsoundevent:Notification.Default' } else { 'ms-winsoundevent:Notification.Reminder' }
$xml = New-Object Windows.Data.Xml.Dom.XmlDocument
$xml.LoadXml("<toast duration='short'><visual><binding template='ToastGeneric'><image placement='appLogoOverride' src='$iconUri'/><text>$title</text><text>$body</text></binding></visual><audio src='$sound'/></toast>")

$toast = [Windows.UI.Notifications.ToastNotification]::new($xml)
$toast.Tag = 'toggle_mic'
$toast.Group = 'toggle_mic'
$toast.ExpirationTime = [DateTimeOffset]::Now.AddSeconds(5)

$appId = '{1AC14E77-02E7-4E5D-B744-2EB1AE5198B7}\WindowsPowerShell\v1.0\powershell.exe'
[Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier($appId).Show($toast)
