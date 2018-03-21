
BACKUP_FROM=$1
BACKUP_TO=$2

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
curl -L https://github.com/docker/compose/releases/download/1.17.1/docker-compose-"$(uname -s)-$(uname -m)" > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
usermod -aG docker $USERNAME
systemctl status docker.service
systemctl enable docker.service
systemctl start docker.service

# clipboard
yum install -y epel-release
yum install -y xsel
yum install -y xclip
yum-config-manager --disable epel
yum -y install libXrandr
yum -y install xorg-x11-server-Xvfb

# git
yum -y install wget
yum -y install dh-autoreconf curl-devel expat-devel gettext-devel openssl-devel perl-devel zlib-devel
yum -y install libtool autoconf automake cmake gcc gcc-c++ make pkgconfig unzip
GITVERSION=2.15.0
wget -nv https://www.kernel.org/pub/software/scm/git/git-$GITVERSION.tar.gz
tar -zxf git-$GITVERSION.tar.gz
rm git-$GITVERSION.tar.gz
cd git-$GITVERSION
unset GITVERSION
make prefix=/usr/local all
make prefix=/usr/local install

# neovim
NEOVIMDIR=$APPDIR/neovim
yum -y install libtool autoconf automake cmake gcc gcc-c++ make pkgconfig unzip
git clone https://github.com/neovim/neovim.git $NEOVIMDIR
cd $NEOVIMDIR
make CMAKE_BUILD_TYPE=Release
make install

# vim
VIMDIR=$APPDIR/vim
git clone https://github.com/neovim/neovim.git $VIMDIR
cd $VIMDIR/src
./configure \
--with-features=huge \
--enable-gui=gtk2 \
--enable-pythoninterp \
--with-python-config-dir=/usr/lib64/python2.7/config \
--enable-python3interp \
--with-python3-config-dir=/usr/lib64/python3.5/config-3.5m \
--enable-fail-if-missing
make
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
wget -nv https://github.com/monochromegane/the_platinum_searcher/releases/download/v2.1.5/pt_linux_amd64.tar.gz
tar zxf pt_linux_amd64.tar.gz
mv pt_linux_amd64/pt /usr/local/bin/pt
rm pt_linux_amd64.tar.gz
rm -r pt_linux_amd64

# ripgrep
yum-config-manager --add-repo=https://copr.fedorainfracloud.org/coprs/carlwgeorge/ripgrep/repo/epel-7/carlwgeorge-ripgrep-epel-7.repo
yum -y install ripgrep

chown $USERNAME:$USERNAME -R $APPDIR

cp -f /vagrant/provision/.bash_profile $USERDIR/.bash_profile
cp -f /vagrant/provision/.bashrc $USERDIR/.bashrc

# python3
yum install -y https://centos7.iuscommunity.org/ius-release.rpm
yum install -y python35u python35u-libs python35u-devel python35u-pip
yum-config-manager --disable ius
pip3.5 install neovim
pip3.5 install flake8
pip3.5 install requests
pip3.5 install mypy
pip3.5 install autopep8
pip3.5 install isort
pip3.5 install yapf
pip3.5 install lxml
pip3.5 install python-language-server

# python2
yum -y install python-devel 
yum -y install python-pip --enablerepo epel
pip install neovim

ln -s /usr/bin/python3.5 /usr/bin/python3

# php
yum install -y http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
yum install -y --enablerepo=remi-php71 php php-cli php-common php-devel php-fpm php-gd php-mbstring php-mysqlnd php-pdo php-pear php-pecl-apcu php-soap php-xml php-xmlrpc php-pecl-xdebug

# composer
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php composer-setup.php
php -r "unlink('composer-setup.php');"
mv composer.phar /usr/local/bin/composer

# shell script
yum install -y ShellCheck --enablerepo epel

# golang
GOVERSION=1.9.2
wget -nv https://storage.googleapis.com/golang/go$GOVERSION.linux-amd64.tar.gz
tar -C /usr/local -xzf go$GOVERSION.linux-amd64.tar.gz
rm go$GOVERSION.linux-amd64.tar.gz

# java
wget -nv --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u151-b12/e758a0de34e24606bca991d704f6dcbf/jdk-8u151-linux-x64.rpm
yum -y localinstall jdk-8u151-linux-x64.rpm
rm jdk-8u151-linux-x64.rpm

# plantuml
wget -nv https://sourceforge.net/projects/plantuml/files/plantuml.jar

# clang
yum -y install clang lldb

rpm --import "http://keyserver.ubuntu.com/pks/lookup?op=get&search=0x3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF"
yum-config-manager --add-repo http://download.mono-project.com/repo/centos/
yum install -y mono-complete

wget -nv --no-check-certificate https://nuget.org/nuget.exe
mono nuget.exe update -self
mv nuget.exe /usr/local/bin
cp -f /vagrant/provision/nuget.sh /usr/local/bin/nuget
cp -f /vagrant/provision/nugetinstall.sh /usr/local/bin/nugetinstall

rpm --import https://packages.microsoft.com/keys/microsoft.asc
sh -c 'echo -e "[packages-microsoft-com-prod]\nname=packages-microsoft-com-prod \nbaseurl=https://packages.microsoft.com/yumrepos/microsoft-rhel7.3-prod\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/dotnetdev.repo'
yum -y install libunwind libicu
yum -y install dotnet-sdk-2.0.0

# Vim script
pip3.5 install vim-vint

# sqlint
gem install sqlint

# javascript
curl -sL https://rpm.nodesource.com/setup_9.x | bash -E -
yum install -y nodejs
npm install -g javascript-typescript-langserver

npm i -g typescript
npm i -g neovim
npm i -g gulp
npm i -g htmlhint
npm i -g eslint
npm i -g prettier

# lua
yum install -y lua-devel
yum install -y luarocks --enablerepo=epel
luarocks install luacheck

# text browser
yum -y install lynx

# word dict
yum -y install words

# dotfiles for root
git clone https://github.com/notomo/dotfiles.git ~/dotfiles
sh ~/dotfiles/link.sh

# sync
sysctl fs.inotify.max_user_watches=32768
echo fs.inotify.max_user_watches=32768 >> /etc/sysctl.conf
yum -y install lsyncd --enablerepo=epel
yum -y install xinetd

mkdir -p "$BACKUP_FROM"
mkdir -p "$BACKUP_TO"
chown $USERNAME:$USERNAME "$BACKUP_FROM"
chown $USERNAME:$USERNAME "$BACKUP_TO"
cp -f /vagrant/provision/lsyncd.conf /etc/lsyncd.conf
sed -i 's#BACKUP_TO#'"$BACKUP_TO"'#g' /etc/lsyncd.conf
cp -f /vagrant/provision/rsync_exclude_list /etc/rsync_exclude_list
rsync -a --exclude-from=/vagrant/provision/rsync_exclude_list "$BACKUP_FROM" $USERDIR

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

# fish
# yum install ncurses-devel
# cd /etc/yum.repos.d/
# wget -nv http://download.opensuse.org/repositories/shells:fish:release:2/CentOS_7/shells:fish:release:2.repo
# yum -y install fish
# cd $APPDIR

# blender
# wget -nv http://mirror.cs.umn.edu/blender.org/release/Blender2.78/blender-2.78c-linux-glibc219-x86_64.tar.bz2
# tar xf blender-2.78c-linux-glibc219-x86_64.tar.bz2
# rm blender-2.78c-linux-glibc219-x86_64.tar.bz2
# mv blender-2.78c-linux-glibc219-x86_64 blender
# yum -y install glib*
# yum -y install libGLU
# yum -y install libXi

yum -y install tree

yum -y install xdg-utils

# tee /etc/yum.repos.d/highway.repo <<-EOF
# [repos.highway]
# name=highway
# baseurl=http://tkengo.github.io/highway/fedora
# enabled=0
# gpgcheck=0
# EOF
# yum -y install highway --enablerepo="repos.highway"
