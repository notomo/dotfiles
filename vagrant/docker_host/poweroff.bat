set bat_path=%~dp0

REM replace \ -> #
set target_path=%bat_path:\=#%

REM replace : -> #
set target_path=%target_path::=#%

REM slice by index
set target_path=%target_path:~0,-1%

"C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" controlvm %target_path% poweroff
exit
