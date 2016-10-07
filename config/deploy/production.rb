server '131.206.19.97', user: 'murakami', roles: %w{app db web}
set :ssh_options, {
    keys: %w(~/.ssh/ishizaka-lab/id_rsa),
    forward_agent: true,
    auth_methods: %w(publickey)
  }

set :branch, "master"
role :web, "ishizaka-lab"