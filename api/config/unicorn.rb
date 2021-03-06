# Set path to application
app_dir = File.expand_path("../..", __FILE__)
shared_dir = "#{app_dir}/shared"
working_directory app_dir

# Set unicorn options
worker_processes 3
preload_app true
timeout 30

# Socket location
listen "0.0.0.0:3000"

# Logging
stderr_path "#{shared_dir}/log/unicorn.stderr.log"
stdout_path "#{shared_dir}/log/unicorn.stdout.log"

# Master PID
pid "#{shared_dir}/pids/unicorn.pid"
