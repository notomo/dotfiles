cp -f /vagrant/provision/lsyncd.conf /etc/lsyncd.conf
cp -f /vagrant/provision/rsync_exclude.lst /etc/rsync_exclude.lst
systemctl restart lsyncd
