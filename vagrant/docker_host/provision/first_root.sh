
USERNAME=vagrant
USERDIR=/home/$USERNAME

APPDIR=$USERDIR/app
mkdir -p $APPDIR
cd $APPDIR

timedatectl set-timezone Asia/Tokyo

yum update

# docker, docker-compose
yum -y install yum-utils
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum makecache fast
yum -y install docker-ce
curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-"$(uname -s)-$(uname -m)" > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
usermod -aG docker $USERNAME
systemctl status docker.service
systemctl enable docker.service
systemctl start docker.service
cp -f /vagrant/provision/daemon.json /etc/docker/daemon.json
systemctl restart docker.service

# clipboard
yum install -y epel-release
yum install -y xsel
yum install -y xclip
yum-config-manager --disable epel
yum -y install libXrandr
yum -y install xorg-x11-server-Xvfb
yum -y --enablerepo=epel install fuse-sshfs 

# git
yum -y install wget
yum -y install dh-autoreconf curl-devel expat-devel gettext-devel openssl-devel perl-devel zlib-devel
yum -y install libtool autoconf automake cmake gcc gcc-c++ make pkgconfig unzip
GITVERSION=2.18.0
wget -nv https://www.kernel.org/pub/software/scm/git/git-$GITVERSION.tar.gz
tar -zxf git-$GITVERSION.tar.gz
rm git-$GITVERSION.tar.gz
cd git-$GITVERSION
unset GITVERSION
make prefix=/usr/local all
make prefix=/usr/local install

# neovim build tools
yum -y install ninja-build libtool autoconf automake cmake gcc gcc-c++ make pkgconfig unzip

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
wget -nv https://github.com/monochromegane/the_platinum_searcher/releases/download/v2.1.6/pt_linux_amd64.tar.gz
tar zxf pt_linux_amd64.tar.gz
mv pt_linux_amd64/pt /usr/local/bin/pt
rm pt_linux_amd64.tar.gz
rm -r pt_linux_amd64

chown $USERNAME:$USERNAME -R $APPDIR

cp -f /vagrant/provision/.bash_profile $USERDIR/.bash_profile
cp -f /vagrant/provision/.bashrc $USERDIR/.bashrc
cp -f /vagrant/provision/.inputrc $USERDIR/.inputrc

# python3
yum install -y https://centos7.iuscommunity.org/ius-release.rpm
yum install -y python36u python36u-libs python36u-devel python36u-pip
yum-config-manager --disable ius
pip3.6 install neovim
pip3.6 install flake8
pip3.6 install requests
pip3.6 install mypy
pip3.6 install autopep8
pip3.6 install isort
pip3.6 install yapf
pip3.6 install pytest
pip3.6 install pytest-cov

# python2
yum -y install python-devel 
yum -y install python-pip --enablerepo epel
pip install neovim

ln -s /usr/bin/python3.6 /usr/bin/python3

# php
yum install -y http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
yum install -y --enablerepo=remi-php71 php php-cli php-common php-devel php-fpm php-gd php-mbstring php-mysqlnd php-pdo php-pecl-apcu php-soap php-xml php-xmlrpc php-pecl-xdebug

# composer
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

# golang
GOVERSION=1.10.3
wget -nv https://storage.googleapis.com/golang/go$GOVERSION.linux-amd64.tar.gz
tar -C /usr/local -xzf go$GOVERSION.linux-amd64.tar.gz
rm go$GOVERSION.linux-amd64.tar.gz

# Vim script
pip3.5 install vim-vint

# javascript
curl -sL https://rpm.nodesource.com/setup_9.x | bash -E -
yum install -y nodejs

npm i -g typescript
npm i -g neovim
npm i -g htmlhint
npm i -g eslint
npm i -g prettier
npm i -g tslint
npm i -g fixjson
# npm i -g vue-language-server
# npm i -g stylelint stylelint-config-standard

# text browser
yum -y install lynx

# word dict
yum -y install words

# sync
sysctl fs.inotify.max_user_watches=32768
echo fs.inotify.max_user_watches=32768 >> /etc/sysctl.conf
yum -y install lsyncd --enablerepo=epel
yum -y install xinetd

cp -f /vagrant/provision/lsyncd.conf /etc/lsyncd.conf
cp -f /vagrant/provision/rsync_exclude_list /etc/rsync_exclude_list

systemctl start xinetd
systemctl enable xinetd
systemctl start rsyncd
systemctl enable rsyncd
systemctl start lsyncd
systemctl enable lsyncd

mkdir -p $USERDIR/.ssh
chown $USERNAME:$USERNAME -R $USERDIR/.ssh/*
chmod 0600 $USERDIR/.ssh/*
chmod 0700 $USERDIR/.ssh

yum -y install tree
yum -y install telnet

yum -y install xdg-utils
