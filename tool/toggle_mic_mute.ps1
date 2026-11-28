# Toggle mute of a specific recording device.
#   toggle_mic_mute.ps1 -List            : list recording devices
#   toggle_mic_mute.ps1 -Name "*Realtek*" : toggle mute of matched device(s)
param(
  [string]$Name,
  [switch]$List
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
  }

  [ComImport, Guid("0BD7A1BE-7A1A-44DB-8397-CC5392387B5E"), InterfaceType(ComInterfaceType.InterfaceIsIUnknown)]
  interface IMMDeviceCollection {
    int GetCount(out int c);
    int Item(int i, out IMMDevice d);
  }

  [ComImport, Guid("A95664D2-9614-4F35-A746-DE8DB63617E6"), InterfaceType(ComInterfaceType.InterfaceIsIUnknown)]
  interface IMMDeviceEnumerator {
    int EnumAudioEndpoints(int flow, int mask, out IMMDeviceCollection c);
  }

  [ComImport, Guid("BCDE0395-E52F-467C-8E3D-C4579291692E")]
  class MMDeviceEnumerator {}

  [ComImport, Guid("5CDF2C82-841E-4546-9722-0CF74078229A"), InterfaceType(ComInterfaceType.InterfaceIsIUnknown)]
  interface IAudioEndpointVolume {
    int f1(); int f2(); int f3(); int f4(); int f5(); int f6();
    int f7(); int f8(); int f9(); int f10(); int f11();
    int SetMute([MarshalAs(UnmanagedType.Bool)] bool mute, ref Guid ctx);
    int GetMute([MarshalAs(UnmanagedType.Bool)] out bool mute);
  }

  public class Mic {
    public string Name;
    IAudioEndpointVolume vol;

    public bool Muted {
      get { bool m; Marshal.ThrowExceptionForHR(vol.GetMute(out m)); return m; }
      set { Guid g = Guid.Empty; Marshal.ThrowExceptionForHR(vol.SetMute(value, ref g)); }
    }

    public static List<Mic> GetAll() {
      var list = new List<Mic>();
      var en = (IMMDeviceEnumerator)new MMDeviceEnumerator();
      IMMDeviceCollection col;
      Marshal.ThrowExceptionForHR(en.EnumAudioEndpoints(1, 1, out col)); // eCapture, ACTIVE
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
        var iid = typeof(IAudioEndpointVolume).GUID;
        object o;
        Marshal.ThrowExceptionForHR(d.Activate(ref iid, 23, IntPtr.Zero, out o));
        list.Add(new Mic { Name = Marshal.PtrToStringUni(v.p1), vol = (IAudioEndpointVolume)o });
      }
      return list;
    }
  }
}
'@

$mics = [MicToggle.Mic]::GetAll()

if ($List -or -not $Name) {
  $mics | ForEach-Object { '{0}  (muted: {1})' -f $_.Name, $_.Muted }
  return
}

$targets = @($mics | Where-Object { $_.Name -like $Name })
if ($targets.Count -eq 0) {
  Write-Error "device not found: $Name"
  exit 1
}

$muted = -not $targets[0].Muted
foreach ($m in $targets) { $m.Muted = $muted }

# feedback: toast notification (replaces previous one via Tag/Group)
[Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime] | Out-Null
[Windows.Data.Xml.Dom.XmlDocument, Windows.Data.Xml.Dom.XmlDocument, ContentType = WindowsRuntime] | Out-Null

$icon = if ($muted) { [char]::ConvertFromUtf32(0x1F507) } else { [char]::ConvertFromUtf32(0x1F3A4) } # speaker with cancellation stroke / microphone
$title = if ($muted) { "$icon Mic muted" } else { "$icon Mic unmuted" }
$body = [System.Security.SecurityElement]::Escape(($targets | ForEach-Object { $_.Name }) -join ', ')
function New-MicIcon([bool]$Muted, [string]$Path) {
  Add-Type -AssemblyName System.Drawing
  $bmp = New-Object System.Drawing.Bitmap 96, 96
  $g = [System.Drawing.Graphics]::FromImage($bmp)
  $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias

  $bg = if ($Muted) { [System.Drawing.Color]::FromArgb(220, 53, 69) } else { [System.Drawing.Color]::FromArgb(40, 167, 69) }
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

  if ($Muted) {
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

$iconPath = Join-Path $env:TEMP ('toggle_mic_mute_{0}.png' -f $(if ($muted) { 'muted' } else { 'unmuted' }))
New-MicIcon $muted $iconPath
$iconUri = ([Uri]$iconPath).AbsoluteUri

$sound = if ($muted) { 'ms-winsoundevent:Notification.Reminder' } else { 'ms-winsoundevent:Notification.Default' }
$xml = New-Object Windows.Data.Xml.Dom.XmlDocument
$xml.LoadXml("<toast duration='short'><visual><binding template='ToastGeneric'><image placement='appLogoOverride' src='$iconUri'/><text>$title</text><text>$body</text></binding></visual><audio src='$sound'/></toast>")

$toast = [Windows.UI.Notifications.ToastNotification]::new($xml)
$toast.Tag = 'toggle_mic_mute'
$toast.Group = 'toggle_mic_mute'
$toast.ExpirationTime = [DateTimeOffset]::Now.AddSeconds(5)

$appId = '{1AC14E77-02E7-4E5D-B744-2EB1AE5198B7}\WindowsPowerShell\v1.0\powershell.exe'
[Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier($appId).Show($toast)
