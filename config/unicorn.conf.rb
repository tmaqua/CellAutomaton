
app_path = "/var/www/rails/CellAutomaton"
current_path = "#{app_path}/current"
shared_path = "#{app_path}/shared"

worker_processes 2
working_directory "#{current_path}"

listen "#{shared_path}/tmp/sockets/.unicorn.sock", :backlog => 64

timeout 60

pid "#{shared_path}/tmp/pids/unicorn.pid"

stderr_path "#{shared_path}/log/unicorn.stderr.log"
stdout_path "#{shared_path}/log/unicorn.stdout.log"

preload_app true
GC.respond_to?(:copy_on_write_friendly=) and
    GC.copy_on_write_friendly = true

check_client_connection false
run_once = true

# Gemfile を変更したときにも読み込まれるようにする。 see: http://qiita.com/tachiba/items/7eef03cce6a917a957dc
before_exec do |server|
  ENV['BUNDLE_GEMFILE'] = "#{current_path}/Gemfile"
end

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and
      ActiveRecord::Base.connection.disconnect!
  if run_once
    run_once = false # prevent from firing again
  end
  old_pid = "#{server.config[:pid]}.oldbin"
  if File.exist?(old_pid) && server.pid != old_pid
    begin
      sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
      Process.kill(sig, File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH => e
      logger.error e
    end
  end
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and
      ActiveRecord::Base.establish_connection
end