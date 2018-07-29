
if [ -e /usr/bin/xdg-open ]
then
    mv /usr/bin/xdg-open /usr/bin/xdg-open.tmp
fi
ln -s "$GOPATH"/bin/lemonade /usr/bin/xdg-open
