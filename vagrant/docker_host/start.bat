start lemonade.exe server
cd %HOMEPATH%"\dotfiles\vagrant\docker_host"
vagrant up > vagrant_up.log 2>&1
start %HOMEPATH%"\app\rlogin_x64\RLogin.exe" /entry vagrant /inuse /inusea
exit
