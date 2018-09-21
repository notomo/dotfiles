# connect power supply
xcode-select --install
# click install

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
# input password

brew install ansible

git clone https://github.com/notomo/dotfiles.git ~/dotfiles

cd ~/dotfiles/ansible
ansible-playbook playbooks/mac.yml
