##
# Unicorn config at /etc/unicorn/app.rb
# Managed by Chef - Local Changes will be Nuked from Orbit (just to be sure)
##

# What ports/sockets to listen on, and what options for them.
listen "127.0.0.1:8080", {:tcp_nodelay=>true, :backlog=>100}

working_directory '/home/turbobil/deploy/app/current'

# What the timeout for killing busy workers is, in seconds
timeout 60

# Whether the app should be pre-loaded
preload_app false

# How many worker processes
worker_processes 2




# What to do before we fork a worker
before_fork do |server, worker|
  ENV["LOG_LEVEL"] = "debug"
  sleep 1
end


