server '52.196.218.185', user: 'murakami', roles: %w{app db web}
set :ssh_options, {
    keys: %w(~/.ssh/aws.gakufes/id_rsa),
    forward_agent: true,
    auth_methods: %w(publickey)
  }

set :branch, "master"