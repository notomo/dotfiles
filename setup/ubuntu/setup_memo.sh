cd /etc/apt
sudo sed -i.bak -e "s/http:\/\/archive\.ubuntu\.com/http:\/\/jp\.archive\.ubuntu\.com/g" sources.list
diff -u sources.list.bak sources.list

cd ~

sudo apt --yes update
sudo apt --yes upgrade

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew install ansible

git clone https://github.com/notomo/dotfiles.git ~/dotfiles

cd ~/dotfiles/ansible
ANSIBLE_CONFIG=$(pwd) ansible-playbook playbooks/ubuntu.yml --ask-become-pass
