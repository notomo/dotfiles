sudo apt update
sudo apt install --yes software-properties-common
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt install --yes ansible
cd ansible
ANSIBLE_CONFIG=$(pwd) ansible-playbook playbooks/ubuntu.yml -e ansible_python_interpreter=`which python` --tags=workspace --tags=bash --tags=dotfiles --tags=neovim
