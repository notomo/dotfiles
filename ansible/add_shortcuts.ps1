$WshShell = New-Object -comObject WScript.Shell

$PowerOffShortcut = $WshShell.CreateShortcut("$Home\Desktop\vagrant_poweroff.lnk")
$PowerOffShortcut.TargetPath = "C:\Windows\System32\cmd.exe"
$PowerOffShortcut.Arguments = "/C $HOME\dotfiles\ansible\poweroff.bat"
$PowerOffShortcut.WorkingDirectory = "$HOME\dotfiles\ansible"
$PowerOffShortcut.Save()

$StartShortcut = $WshShell.CreateShortcut("$Home\Desktop\vagrant_start.lnk")
$StartShortcut.TargetPath = "C:\Windows\System32\cmd.exe"
$StartShortcut.Arguments = "/C $HOME\dotfiles\ansible\start_vagrant.bat"
$StartShortcut.WorkingDirectory = "$HOME\dotfiles\ansible"
$StartShortcut.Save()

Read-Host "Exit by press Enter."
