
USERNAME=vagrant
USERDIR=/home/$USERNAME

yum update

# docker, docker-compose
tee /etc/yum.repos.d/docker.repo <<-EOF
[dockerrepo]
name=Docker Repository
baseurl=https://yum.dockerproject.org/repo/main/centos/7
enabled=1
gpgcheck=1
gpgkey=https://yum.dockerproject.org/gpg
EOF
yum install -y docker-engine
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

# neovim
APPDIR=$USERDIR/app
NEOVIMDIR=$APPDIR/neovim
mkdir -p $APPDIR
yum -y install libtool autoconf automake cmake gcc gcc-c++ make pkgconfig unzip
git clone https://github.com/neovim/neovim.git $NEOVIMDIR
cd $NEOVIMDIR
make CMAKE_BUILD_TYPE=RelWithDebInfo
make install

# ctags
CTAGSDIR=$APPDIR/ctags
git clone https://github.com/universal-ctags/ctags.git $CTAGSDIR
cd $CTAGSDIR
./autogen.sh
./configure --prefix=/usr/local
make
make install

# pt
cd $APPDIR
wget https://github.com/monochromegane/the_platinum_searcher/releases/download/v2.1.5/pt_linux_amd64.tar.gz
tar zxf pt_linux_amd64.tar.gz
mv pt_linux_amd64/pt /usr/local/bin/pt

chown $USERNAME:$USERNAME -R $APPDIR

cp -f /vagrant/provision/.bash_profile $USERDIR/.bash_profile
cp -f /vagrant/provision/.bashrc $USERDIR/.bashrc

# python3
yum install -y https://centos7.iuscommunity.org/ius-release.rpm
yum install -y python35u python35u-libs python35u-devel python35u-pip
yum-config-manager --disable ius
pip3.5 install neovim
pip3.5 install flake8

# python2
yum -y install python-pip --enablerepo epel
pip install neovim

# ruby
yum -y install ruby ruby-devel
gem install neovim

# php
yum install -y http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
yum install -y --enablerepo=remi-php71 php php-cli php-common php-devel php-fpm php-gd php-mbstring php-mysqlnd php-pdo php-pear php-pecl-apcu php-soap php-xml php-xmlrpc

# composer
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php composer-setup.php
php -r "unlink('composer-setup.php');"
mv composer.phar /usr/local/bin/composer

# shell script
yum install -y ShellCheck --enablerepo epel

# golang
yum install -y golang --enablerepo epel

# Vim script
pip3.5 install vim-vint

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

# text browser
yum -y install lynx

# dotfiles for root
git clone https://github.com/tmn-o3/dotfiles.git
sh ~/dotfiles/link.sh

# gui
yum -y groupinstall "X Window System"
yum -y install dconf

# firefox
yum -y install firefox

# chrome
sudo tee /etc/yum.repos.d/google.chrome.repo <<-EOF
[google-chrome]
name=google-chrome - 64-bit
baseurl=http://dl.google.com/linux/chrome/rpm/stable/x86_64
enabled=1
gpgcheck=1
gpgkey=https://dl-ssl.google.com/linux/linux_signing_key.pub
EOF
sudo yum install -y google-chrome-stable

# guest additions
yum -y  groupinstall "Development Tools"
yum -y install kernel-devel kernel-headers
VB_DL_URL=http://download.virtualbox.org/virtualbox
VB_LATEST_VERSION=$(curl -s $VB_DL_URL/LATEST.TXT)
wget $VB_DL_URL/$VB_LATEST_VERSION/VBoxGuestAdditions_$VB_LATEST_VERSION.iso
mkdir /media/iso
mount -o loop ./VBoxGuestAdditions_$VB_LATEST_VERSION.iso /media/iso
export KERN_DIR=`ls -t /usr/src/kernels/|head -1`
sh /media/iso/VBoxLinuxAdditions.run
umount /media/iso

# sync
yum -y install lsyncd --enablerepo=epel
