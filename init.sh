rm -f tmp/pids/server.pid
rake db:create && rake db:migrate
rake db:seed
rake db:migrate RAILS_ENV=test
rake es:create_index