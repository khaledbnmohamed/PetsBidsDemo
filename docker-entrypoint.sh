#!/bin/bash
set -e

if [ -f /home/camelan/camelan/tmp/pids/server.pid ]; then
  rm /home/camelan/camelan/tmp/pids/server.pid
fi

gem install bundler
bundle install

bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake seed:create_seeds


# overcommit --install
# overcommit --sign
exec "$@"
