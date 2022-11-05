rm -f tmp/pids/server.pid
rake db:create && rake db:migrate
rake db:seed
rake es:create_index