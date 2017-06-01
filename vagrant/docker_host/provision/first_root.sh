
USERNAME=vagrant
USERDIR=/home/$USERNAME

yum update

# docker, docker-compose
yum install -y docker
curl -L https://github.com/docker/compose/releases/download/1.13.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
groupadd docker
usermod -aG docker vagrant
service docker start
chkconfig docker on

# clipboard
yum install -y epel-release
yum install -y xsel
yum-config-manager --disable epel
yum -y install xorg-x11-server-Xvfb

# vim
yum install -y vim

# neovim
APPDIR=$USERDIR/app
NEOVIMDIR=$APPDIR/neovim
mkdir -p $APPDIR
yum -y install libtool autoconf automake cmake gcc gcc-c++ make pkgconfig unzip
git clone https://github.com/neovim/neovim.git $NEOVIMDIR
cd $NEOVIMDIR
make CMAKE_BUILD_TYPE=RelWithDebInfo CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$NEOVIMDIR"
make install

# git
yum -y install wget
yum -y install dh-autoreconf curl-devel expat-devel gettext-devel openssl-devel perl-devel zlib-devel
yum -y install libtool autoconf automake cmake gcc gcc-c++ make pkgconfig unzip
GITVERSION=2.12.0
wget https://www.kernel.org/pub/software/scm/git/git-$GITVERSION.tar.gz
tar -zxf git-$GITVERSION.tar.gz
cd git-$GITVERSION
unset GITVERSION
make prefix=/usr/local all
make prefix=/usr/local install

cp /vagrant/provision/.bash_profile /home/vagrant/.bash_profile
cp /vagrant/provision/.bashrc /home/vagrant/.bashrc

# python3
yum install -y https://centos7.iuscommunity.org/ius-release.rpm
yum install -y python34u python34u-libs python34u-devel python34u-pip
yum-config-manager --disable ius
pip3 install neovim

# python2
yum -y install python-pip --enablerepo epel
pip install neovim

# ruby
yum -y install ruby ruby-devel
gem install neovim

# vagrant key
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

