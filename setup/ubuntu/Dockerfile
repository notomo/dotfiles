# syntax=docker/dockerfile:1

FROM ubuntu:22.04

ARG USERNAME=notomo
ARG PASSWORD=notomo
RUN <<EOF
  sed -i -e "s/http:\/\/archive\.ubuntu\.com/http:\/\/jp\.archive\.ubuntu\.com/g" /etc/apt/sources.list
  apt update
  apt upgrade
  apt install sudo
  groupadd -g 1000 $USERNAME
  useradd --create-home --shell /bin/bash -u 1000 -g 1000 -G sudo $USERNAME
  echo $USERNAME:$PASSWORD | chpasswd
  echo "[user]\ndefault=$USERNAME" > /etc/wsl.conf
  DEBIAN_FRONTEND=noninteractive apt install tzdata
EOF
ENV TZ=Asia/Tokyo

# install brew
RUN <<EOF
  apt install -y build-essential procps curl file git
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  chown -R $USERNAME:$USERNAME /home/linuxbrew/.linuxbrew
EOF

USER $USERNAME
ENV PATH=$PATH:/home/linuxbrew/.linuxbrew/bin USER=$USERNAME GIT_EMAIL=empty
RUN <<EOF
  eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
  brew install ansible
  brew install python
EOF

COPY ansible /_ansible
RUN <<EOF
  cd /_ansible
  ANSIBLE_CONFIG=$(pwd) ansible-playbook playbooks/ubuntu.yml \
    --tags workspace \
    --tags dotfiles \
    --tags bash \
    --tags zsh \
    --tags neovim \
    --tags tools \
    --tags gh \
    --tags ctags \
    --tags lua \
    --tags node \
    --tags deno \
    --tags wslu \
    --tags gitconfig
EOF

COPY --chown=$USERNAME:$USERNAME thetto.nvim /home/$USERNAME/.local/share/nvim/thetto.nvim
COPY --chown=$USERNAME:$USERNAME .ssh /home/$USERNAME/.ssh
