#!/bin/sh -e

# for recording deployments of New Relic
curl -Ls -o config/newrelic.yml $NEWRELIC_FILE_PATH

cat <<EOF >> $HOME/.ssh/config
Host masutaka.net
  User masutaka
  ForwardAgent yes
EOF

ssh-add $HOME/.ssh/id_circleci_github

bundle exec cap prod deploy
