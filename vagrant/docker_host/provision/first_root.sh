yum update
yum install -y docker
curl -L https://github.com/docker/compose/releases/download/1.13.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
groupadd docker
usermod -aG docker vagrant
service docker start
chkconfig docker on
yum install -y vim
yum install epel-release
yum install -y xsel
yum-config-manager --disable epel
yum -y install xorg-x11-server-Xvfb
cp /vagrant/provision/.bash_profile /home/vagrant/.bash_profile
cp /vagrant/provision/.bashrc /home/vagrant/.bashrc
