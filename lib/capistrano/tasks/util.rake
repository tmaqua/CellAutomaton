namespace :util do
  desc 'Upload env/pem'
  task :upload do
    on roles(:app) do |host|
      upload!('.env', "#{shared_path}/.env")
    end
  end
end