cd ~/dotfiles
git fetch origin master
git reset --hard origin/master
cp /vagrant/provision/.bash_profile /home/vagrant/.bash_profile
cp /vagrant/provision/.bashrc /home/vagrant/.bashrc
