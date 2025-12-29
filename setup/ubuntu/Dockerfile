# syntax=docker/dockerfile:1

FROM ubuntu:24.04

ARG USERNAME=notomo
ARG PASS=notomo
RUN <<EOF
  sed -i -e "s/http:\/\/archive\.ubuntu\.com/http:\/\/jp\.archive\.ubuntu\.com/g" /etc/apt/sources.list
  apt update
  apt upgrade
  apt install -y sudo
  groupadd -g 1001 $USERNAME
  useradd --create-home --shell /bin/bash -u 1001 -g 1001 -G sudo $USERNAME
  echo $USERNAME:$PASS | chpasswd
  echo "[user]\ndefault=$USERNAME" > /etc/wsl.conf
  DEBIAN_FRONTEND=noninteractive apt install tzdata
  apt install -y locales
  locale-gen en_US.UTF-8
  apt install -y unminimize
  yes | unminimize
  apt install -y man
  apt install -y xvfb libxrandr2
  apt install -y git ca-certificates build-essential
  apt install -y zsh
  apt install -y curl
  apt install -y zip
  apt install -y wget
  apt install -y lsof
  apt install -y nkf
  apt install -y tree
  apt install -y tmpreaper
  chsh -s $(which zsh) $USERNAME
EOF

USER $USERNAME
WORKDIR /home/$USERNAME/
ENV USER=$USERNAME \
    TZ=Asia/Tokyo \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8 \
    DOTFILES="/home/$USERNAME/dotfiles" \
    PATH="/home/$USERNAME/.local/bin:$PATH"

COPY --chown=$USERNAME:$USERNAME thetto.nvim /home/$USERNAME/.local/share/nvim/thetto.nvim
COPY --chown=$USERNAME:$USERNAME mise/config.toml /home/$USERNAME/.config/mise/config.toml
COPY --chown=$USERNAME:$USERNAME gh /home/$USERNAME/.config/gh
COPY --chown=$USERNAME:$USERNAME .bash_profile /home/$USERNAME/.local/.bash_profile
COPY --chown=$USERNAME:$USERNAME .bashrc /home/$USERNAME/.local/.bashrc
COPY --chown=$USERNAME:$USERNAME wslu.sh /_setup/wslu.sh
COPY --chown=$USERNAME:$USERNAME workspace.sh /_setup/workspace.sh
COPY --chown=$USERNAME:$USERNAME shell /_setup/shell
COPY --chown=$USERNAME:$USERNAME git /_setup/git

RUN <<EOF
  curl https://mise.run | sh

  bash /_setup/wslu.sh
  bash /_setup/workspace.sh

  rm ~/.bashrc
  bash /_setup/shell/setup.sh

  bash /_setup/git/setup.sh
  git config --global core.sshCommand "ssh.exe"
  git config --global user.name "${USERNAME}"
EOF

RUN <<EOF
  eval "$(cat /home/$USERNAME/.local/.bash_profile)"
  GITHUB_TOKEN=$(echo $GITHUB_TOKEN) mise install \
    node \
    deno \
    go \
    github:universal-ctags/ctags \
    github:neovim/neovim \
    gh \
    github:dalance/procs \
    npm:@aikidosec/safe-chain \
    npm:fixjson \
    npm:tree-sitter-cli \
    aqua:LuaLS/lua-language-server \
    npm:typescript-language-server \
    npm:@vtsls/language-server \
    npm:@tailwindcss/language-server \
    github:JohnnyMorganz/StyLua \
    aqua:sharkdp/fd \
    aqua:jqlang/jq \
    aqua:BurntSushi/ripgrep \
    go:golang.org/x/tools/cmd/goimports \
    go:golang.org/x/tools/gopls \
  ;
EOF
