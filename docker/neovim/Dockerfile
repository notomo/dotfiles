FROM centos:7
MAINTAINER tmno3

ENV USERNAME user
ENV USERDIR /home/$USERNAME
ENV APPDIR $USERDIR/app
ENV NEOVIMDIR $APPDIR/neovim
ENV DOTFILESDIR $USERDIR/dotfiles
ENV SSHDIR $USERDIR/.ssh

RUN yum clean all

# git
RUN yum -y install wget
RUN yum -y install dh-autoreconf curl-devel expat-devel gettext-devel openssl-devel perl-devel zlib-devel
RUN yum -y install libtool autoconf automake cmake gcc gcc-c++ make pkgconfig unzip
ENV GITVERSION 2.12.0
RUN wget https://www.kernel.org/pub/software/scm/git/git-$GITVERSION.tar.gz
RUN tar -zxf git-$GITVERSION.tar.gz && cd git-$GITVERSION && unset GITVERSION && make prefix=/usr/local all && make prefix=/usr/local install

# python3
RUN yum install -y https://centos7.iuscommunity.org/ius-release.rpm
RUN yum install -y python34u python34u-libs python34u-devel python34u-pip
RUN yum-config-manager --disable ius
RUN pip3 install neovim

# python2
RUN yum -y install python-pip
RUN pip install neovim

# ruby
RUN yum -y install ruby ruby-devel
RUN gem install neovim

# clipboard
RUN yum -y install xsel

# neovim
RUN mkdir -p $APPDIR
RUN yum -y install libtool autoconf automake cmake gcc gcc-c++ make pkgconfig unzip
RUN git clone https://github.com/neovim/neovim.git $NEOVIMDIR
RUN cd $NEOVIMDIR && make CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$NEOVIMDIR" && make install

# mysql
RUN yum install -y http://dev.mysql.com/get/mysql57-community-release-el7-7.noarch.rpm
RUN yum install -y mysql
RUN yum-config-manager --disable mysql*

# ssh config
RUN mkdir -p $SSHDIR
ADD config $SSHDIR/config
RUN chmod 600 $SSHDIR/config

# dotfiles
RUN echo export PATH="$NEOVIMDIR/bin:$PATH" >> $USERDIR/.bash_profile
RUN git clone https://github.com/tmn-o3/dotfiles.git $DOTFILESDIR
RUN chmod a+x $DOTFILESDIR/link.sh
RUN $DOTFILESDIR/link.sh $USERDIR

# user
RUN useradd $USERNAME
RUN chown user:user -R $USERDIR

ENV unset USERNAME
ENV unset USERDIR
ENV unset APPDIR
ENV unset NEOVIMDIR
ENV unset DOTFILESDIR
ENV unset SSHDIR

ENTRYPOINT /bin/bash --login
