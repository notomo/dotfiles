cd /d %~dp0

%ALLUSERSPROFILE%\chocolatey\bin\chocolatey install -y package.config > choco_package.log 2>&1
