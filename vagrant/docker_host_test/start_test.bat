cd %HOMEPATH%"\dotfiles\vagrant\docker_host_test"
xcopy %HOMEPATH%"\dotfiles\vagrant\docker_host\provision" "provision\" /Y /H /I
copy %HOMEPATH%"\dotfiles\vagrant\docker_host\Vagrantfile" "Vagrantfile" /Y
vagrant up 2> vagrant_up.log
exit
