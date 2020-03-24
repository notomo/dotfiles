Add-Type -AssemblyName System.Windows.Forms
$count = [System.Windows.Forms.Screen]::AllScreens.Length
If ($count -eq 2) {
    DisplaySwitch.exe /extend
} Else {
    DisplaySwitch.exe /external
}
