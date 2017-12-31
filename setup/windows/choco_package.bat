cd /d %~dp0

%ALLUSERSPROFILE%\chocolatey\bin\chocolatey install -y package.config > choco_package.log 2>&1

C:\Python35\Scripts\pip3.exe install neovim >> choco_package.log 2>&1
C:\Python27\Scripts\pip.exe install neovim >> choco_package.log 2>&1

C:\PROGRA~1\nodejs\npm install -g neovim

call addPath.wsf "C:\tools\msys64\usr\bin"

echo "%PATH%" >> choco_package.log 2>&1
