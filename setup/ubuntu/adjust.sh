#!/bin/bash

[ ! -d ~/workspace/todo ] && git clone git@github.com:notomo/todo.git ~/workspace/todo

if [ -z "$(git config --global user.email)" ]; then
  git_user_email=
  read -p "input git user email: " git_user_email
  git config --global user.email "${git_user_email}"
fi
