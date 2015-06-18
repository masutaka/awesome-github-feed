#!/bin/sh -ex

cat <<EOF >> $HOME/.ssh/config
Host masutaka.net
  User masutaka
  ForwardAgent yes
EOF

ssh-add $HOME/.ssh/id_circleci_github

bundle exec cap prod deploy
