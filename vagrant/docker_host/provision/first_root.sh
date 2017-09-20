
USERNAME=vagrant
USERDIR=/home/$USERNAME

APPDIR=$USERDIR/app
mkdir -p $APPDIR
cd $APPDIR

yum update

# docker, docker-compose
yum -y install yum-utils
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum makecache fast
yum -y install docker-ce
curl -L https://github.com/docker/compose/releases/download/1.13.0/docker-compose-"$(uname -s)-$(uname -m)" > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
sudo systemctl status docker.service
sudo systemctl enable docker.service

# clipboard
yum install -y epel-release
yum install -y xsel
yum-config-manager --disable epel
yum -y install libXrandr
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
wget https://storage.googleapis.com/golang/go1.8.3.linux-amd64.tar.gz
tar -C /usr/local -xzf go1.8.3.linux-amd64.tar.gz
rm go1.8.3.linux-amd64.tar.gz
go get -u github.com/nsf/gocode
go get golang.org/x/tools/cmd/goimports
go get -u github.com/golang/lint/golint

# java
wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u144-b01/090f390dda5b47b9b721c7dfaa008135/jdk-8u144-lin
yum localinstall jdk-8u144-linux-x64.rpm
rm jdk-8u144-linux-x64.rpm

# plantuml
wget https://sourceforge.net/projects/plantuml/files/plantuml.jar

# clang
yum -y install clang lldb

rpm --import "http://keyserver.ubuntu.com/pks/lookup?op=get&search=0x3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF"
yum-config-manager --add-repo http://download.mono-project.com/repo/centos/
yum install -y mono-complete

wget --no-check-certificate https://nuget.org/nuget.exe
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
yum -y install npm
npm install -g javascript-typescript-langserver

npm i -g typescript

# text browser
yum -y install lynx

# word dict
yum -y install words

# dotfiles for root
git clone https://github.com/notomo/dotfiles.git ~/dotfiles
sh ~/dotfiles/link.sh

# sync
sysctl fs.inotify.max_user_watches = 32768
echo fs.inotify.max_user_watches = 32768 >> /etc/sysctl.conf
yum -y install lsyncd --enablerepo=epel
yum -y install xinetd

cp -f /vagrant/provision/lsyncd.conf /etc/lsyncd.conf
cp -f /vagrant/provision/rsync_exclude.lst /etc/rsync_exclude.lst
rsync -a /hostusr/backup/ $USERDIR

systemctl start xinetd
systemctl enable xinetd
systemctl start rsyncd
systemctl enable rsyncd
systemctl start lsyncd
systemctl enable lsyncd

# fish
# yum install ncurses-devel
cd /etc/yum.repos.d/
wget http://download.opensuse.org/repositories/shells:fish:release:2/CentOS_7/shells:fish:release:2.repo
yum -y install fish
cd $APPDIR

# blender
wget http://mirror.cs.umn.edu/blender.org/release/Blender2.78/blender-2.78c-linux-glibc219-x86_64.tar.bz2
tar xf blender-2.78c-linux-glibc219-x86_64.tar.bz2
rm blender-2.78c-linux-glibc219-x86_64.tar.bz2
mv blender-2.78c-linux-glibc219-x86_64 blender
yum -y install glib*
yum -y install libGLU
yum -y install libXi
