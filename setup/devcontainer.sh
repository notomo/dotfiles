sudo apt update
sudo apt install -y software-properties-common
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt install -y ansible
gh repo clone notomo/dotfiles ~/dotfiles
cd ~/dotfiles/ansible
ANSIBLE_CONFIG=$(pwd) ansible-playbook playbooks/ubuntu.yml -e ansible_python_interpreter=`which python` --tags=workspace --tags=bash --tags=dotfiles --tags=neovim
