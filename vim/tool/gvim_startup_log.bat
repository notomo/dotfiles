cd /d %~dp0
SET log_file=../tmp/startup.log
echo;>> %log_file%
echo;>> %log_file%
echo;>> %log_file%
echo ######################>> %log_file%
echo %date% %time%>> %log_file%
echo ######################>> %log_file%
start gvim --startuptime %log_file% %1
