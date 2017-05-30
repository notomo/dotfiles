FROM centos:7
MAINTAINER tmno3

ENV USERNAME user
ENV USERDIR /home/$USERNAME

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
ENV APPDIR $USERDIR/app
ENV NEOVIMDIR $APPDIR/neovim
RUN mkdir -p $APPDIR
RUN yum -y install libtool autoconf automake cmake gcc gcc-c++ make pkgconfig unzip
RUN git clone https://github.com/neovim/neovim.git $NEOVIMDIR
RUN cd $NEOVIMDIR && make CMAKE_BUILD_TYPE=RelWithDebInfo CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$NEOVIMDIR" && make install

# mysql
RUN yum install -y http://dev.mysql.com/get/mysql57-community-release-el7-7.noarch.rpm
RUN yum install -y mysql
RUN yum-config-manager --disable mysql*

# dotfiles
RUN echo export PATH="$NEOVIMDIR/bin:$PATH" >> $USERDIR/.bash_profile \
    && ln -s $USERDIR/dotfiles/vim/rc/.vimrc $USERDIR/.vimrc \
    && mkdir -p $USERDIR/.vim \
    && ln -s $USERDIR/dotfiles/vim/rc $USERDIR/.vim/rc \
    && ln -s $USERDIR/dotfiles/vim/autoload/ $USERDIR/.vim/autoload \
    && ln -s $USERDIR/dotfiles/vim/dict $USERDIR/.vim/dict \
    && ln -s $USERDIR/dotfiles/vim/snippets $USERDIR/.vim/snippets \
    && ln -s $USERDIR/dotfiles/vim/after $USERDIR/.vim/after \
    && ln -s $USERDIR/dotfiles/vim/ftplugin/ $USERDIR/.vim/ftplugin \
    && ln -s $USERDIR/dotfiles/vim/syntax/ $USERDIR/.vim/syntax \
    && ln -s $USERDIR/dotfiles/vim/indent/ $USERDIR/.vim/indent \
    && ln -s $USERDIR/dotfiles/vim/rplugin $USERDIR/.vim/rplugin \
    && mkdir -p $USERDIR/.vim/tmp/backup \
    && mkdir -p $USERDIR/.vim/tmp/undo \
    && mkdir -p $USERDIR/.vim/tmp/view \
    && mkdir -p $USERDIR/.vim/tmp/swap \
    && mkdir -p $USERDIR/.config \
    && ln -s $USERDIR/.vim $USERDIR/.config/nvim \
    && ln -s $USERDIR/dotfiles/vim/rc/init.vim $USERDIR/.config/nvim/init.vim

# user
RUN useradd $USERNAME
RUN chown user:user -R $USERDIR

RUN unset USERNAME
    && unset USERDIR \
    && unset APPDIR \
    && unset NEOVIMDIR

ENTRYPOINT /bin/bash --login
