KEY_NAME=$1
mkdir -p ~/.ssh
cd ~/.ssh
chown $USER:$USER ~/.ssh
ssh-keygen -f $KEY_NAME -b 4096 -q -P ""
rm authorized_keys
touch authorized_keys
cat ./$KEY_NAME.pub >>authorized_keys
chmod 600 authorized_keys
mv -f ./$KEY_NAME /vagrant/$KEY_NAME
