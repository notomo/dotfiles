yum update

yum install -y docker
curl -L https://github.com/docker/compose/releases/download/1.13.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
groupadd docker
usermod -aG docker vagrant
service docker start
chkconfig docker on

yum install -y vim

yum install -y epel-release
yum install -y xsel
curl -o /etc/yum.repos.d/dperson-neovim-epel-7.repo https://copr.fedorainfracloud.org/coprs/dperson/neovim/repo/epel-7/dperson-neovim-epel-7.repo
yum -y install neovim
yum-config-manager --disable epel

yum -y install xorg-x11-server-Xvfb

yum -y install git

cp /vagrant/provision/.bash_profile /home/vagrant/.bash_profile
cp /vagrant/provision/.bashrc /home/vagrant/.bashrc

# python3
yum install -y https://centos7.iuscommunity.org/ius-release.rpm
yum install -y python34u python34u-libs python34u-devel python34u-pip
yum-config-manager --disable ius
pip3 install neovim

# vagrant key
USERNAME=vagrant
USERDIR=/home/$USERNAME
VAGRANTKEYNAME=vagrant_private_key
VAGRANTKEY=$USERDIR/.ssh/$VAGRANTKEYNAME
cp /vagrant/.vagrant/machines/default/virtualbox/private_key $VAGRANTKEY
chown $USERNAME:$USERNAME $VAGRANTKEY
chmod 600 $VAGRANTKEY

# ssh config
SSHDIR=$USERDIR/.ssh
mkdir -p $SSHDIR
cp /vagrant/provision/ssh_config $SSHDIR/config
DOCKERHOST=`ip addr show eth1 | grep -o 'inet [0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+' | grep -o [0-9].*`
sed -i -e "s/DOCKERHOST/$DOCKERHOST/g" $SSHDIR/config
sed -i -e "s/VAGRANTKEYNAME/$VAGRANTKEYNAME/g" $SSHDIR/config
chown $USERNAME:$USERNAME $SSHDIR/config
chmod 600 $SSHDIR/config
touch $SSHDIR/known_hosts
chown $USERNAME:$USERNAME $SSHDIR/known_hosts
ssh-keyscan -H $DOCKERHOST >> $SSHDIR/known_hosts
chmod 644 $SSHDIR/known_hosts

