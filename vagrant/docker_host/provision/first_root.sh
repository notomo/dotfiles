
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

# text browser
yum -y install lynx

# word dict
yum -y install words

# dotfiles for root
git clone https://github.com/tmn-o3/dotfiles.git ~/dotfiles
sh ~/dotfiles/link.sh

# sync
sysctl fs.inotify.max_user_watches = 32768
echo fs.inotify.max_user_watches = 32768 >> /etc/sysctl.conf
yum -y install lsyncd --enablerepo=epel
yum -y install xinetd

tee /etc/lsyncd.conf <<-EOF
settings {
    logfile    = "/var/log/lsyncd/lsyncd.log",
    statusFile = "/var/log/lsyncd/lsyncd.status",
    insist = 1,
}

sync {
    default.rsync,
    source="/home/vagrant/",
    target="/hostusr/backup/",
    delay = 1,
    excludeFrom="/etc/rsync_exclude.lst",
}
EOF
touch /etc/rsync_exclude.lst
tee /etc/rsync_exclude.lst <<-EOF
/.cache/composer/
/.cache/deoplete/
/.cache/neosnippet/
/.cache/pip/
/.cache/thumbnails/
/.cache/unite/
/.cache/vimfiler/
/.cache/vim-ref/
/.config
/.gem
/.go
/.pdepend
/.pki
/app
/.bash*
/.local/share/
/.flake8
/.git*
/.vbox*
/.vim*
/.vintrc.yaml
/.python_history
EOF

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
