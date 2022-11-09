#!/bin/bash  
set -e
rm -f tmp/pids/server.pid
bundle exec rails db:create
bundle exec rails db:migrate
bundle exec rails db:migrate RAILS_ENV=test
bundle exec rails db:seed
bundle exec rake es:create_index
exec "$@"