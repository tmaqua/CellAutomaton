require 'net/ssh/proxy/command'

# server '131.206.19.97', user: 'murakami', roles: %w{app db web}
set :ssh_options, {
    keys: %w(~/.ssh/ishizaka-lab/id_rsa),
    forward_agent: true,
    auth_methods: %w(publickey)
  }

ssh_command = "ssh kyutech -W %h:%p"
set :ssh_options, proxy: Net::SSH::Proxy::Command.new(ssh_command)
set :user, "murakami"
set :branch, "master"
role :web, "ishizaka-lab"
role :app, "ishizaka-lab"
role :db, "ishizaka-lab"