cd /etc/apt
sudo sed -i.bak -e "s/http:\/\/archive\.ubuntu\.com/http:\/\/jp\.archive\.ubuntu\.com/g" sources.list
diff -u sources.list.bak sources.list

cd ~

sudo apt --yes update
sudo apt --yes upgrade

sudo apt install software-properties-common
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt --yes install ansible

git clone https://github.com/notomo/dotfiles.git ~/dotfiles

cd ~/dotfiles/ansible
ANSIBLE_CONFIG=$(pwd) ansible-playbook playbooks/ubuntu.yml
