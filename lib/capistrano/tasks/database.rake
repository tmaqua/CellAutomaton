namespace :database do

  desc 'db_seed must be run only one time right after the first deploy'
  task :seed do
    on roles(:db) do |host|
      within current_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'db:seed'
        end
      end
    end
  end

  desc 'db_create must be run only one time right after the first deploy'
  task :create do
    on roles(:db) do |host|
      within current_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'db:create'
        end
      end
    end
  end

  desc 'db_reset must be run only one time right after the first deploy'
  task :reset do
    on roles(:db) do |host|
      within current_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'db:migrate:reset'
        end
      end
    end
  end

end