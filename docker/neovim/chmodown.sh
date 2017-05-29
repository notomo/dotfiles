
USERNAME=user
USERDIR=/home/$USERNAME
VAGRANTKEY=$USERDIR/.ssh/vagrant_private_key

mkdir -p $USERDIR/.vim/dein/repos

chmod 777 -R $USERDIR/.cache
chown $USERNAME:$USERNAME -R $USERDIR/.cache

chmod 777 -R $USERDIR/.vim/dein
chown $USERNAME:$USERNAME -R $USERDIR/.vim/dein

cp /vagrant/.vagrant/machines/default/virtualbox/private_key $VAGRANTKEY
chmod 600 $VAGRANTKEY
