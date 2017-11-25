cd %HOMEPATH%"\dotfiles\vagrant\docker_host_test"
vagrant destroy -f > vagrant_up.log.destory 2>&1
del vagrant_key /Q
call start_test.bat
exit
