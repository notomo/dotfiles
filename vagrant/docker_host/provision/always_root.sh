BACKUP_TO=$1
cp -f /vagrant/provision/lsyncd.conf /etc/lsyncd.conf
sed -i 's#BACKUP_TO#'$BACKUP_TO'#g' /etc/lsyncd.conf
cp -f /vagrant/provision/rsync_exclude.lst /etc/rsync_exclude.lst
systemctl restart lsyncd
