
USERNAME=user
USERDIR=/home/$USERNAME

mkdir -p $USERDIR/.vim/dein/repos

chmod 777 -R $USERDIR/.cache
chown $USERNAME:$USERNAME -R $USERDIR/.cache

chmod 777 -R $USERDIR/.vim/dein
chown $USERNAME:$USERNAME -R $USERDIR/.vim/dein

