rm -f tmp/pids/server.pid
rake db:create && rake db:migrate
rake es:create_index