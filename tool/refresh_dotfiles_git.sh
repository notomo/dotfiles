DOTFILES_DIR=~/dotfiles
TMP_DIR=~/dotfiles_tmp
pushd .
rm -r $TMP_DIR
mkdir -p $TMP_DIR
cp -R $DOTFILES_DIR/* $TMP_DIR
rm -rf $DOTFILES_DIR/.git
rm -r $DOTFILES_DIR
git clone https://github.com/notomo/dotfiles.git $DOTFILES_DIR
if [ -d $DOTFILES_DIR ]
then
    cp -R -u $TMP_DIR/* $DOTFILES_DIR/
    rm -r $TMP_DIR
    cd $DOTFILES_DIR
    git reset --hard origin/master
fi
popd
