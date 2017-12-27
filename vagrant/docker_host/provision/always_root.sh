BACKUP_TO=$1
USERNAME=vagrant
mkdir -p $BACKUP_TO
chown $USERNAME:$USERNAME $BACKUP_TO
cp -f /vagrant/provision/lsyncd.conf /etc/lsyncd.conf
sed -i 's#BACKUP_TO#'$BACKUP_TO'#g' /etc/lsyncd.conf
cp -f /vagrant/provision/rsync_exclude_list /etc/rsync_exclude_list
systemctl restart lsyncd
