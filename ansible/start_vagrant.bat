start lemonade.exe server
cd %HOMEPATH%"\dotfiles\ansible"
vagrant up > vagrant_up.log 2>&1
start %HOMEPATH%"\app\rlogin_x64\RLogin.exe" /entry ansible_vagrant /inuse /inusea
exit
