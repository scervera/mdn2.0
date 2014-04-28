# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'mdnapp'
set :repo_url, 'git@github.com:scervera/mdn2.0.git'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/var/mdnapp'

# Default value for :scm is :git
set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
set :pty, true

# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 5


#From old deploy.rb file, not sure if they work in new format
set :ssh_options, { :forward_agent => true }
set :user, "adm1n"
set :group, "adm1n"
set :use_sudo, false
set :shared_children, shared_children + %w{public/uploads}


namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here
      run "cp #{shared_path}/config/database.yml #{latest_release}/config/"
      run "ln -sf #{current_path}/public/ #{deploy_to}"
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end


# Old Tasks

# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end

#   desc "Copy the database.yml file into the latest release"
#   task :copy_in_database_yml do
#     run "cp #{shared_path}/config/database.yml #{latest_release}/config/"
#   end
#   desc "Create symlink from public folder to current/public"
#   task :symlink_to_public do
#     run "ln -sf #{current_path}/public/ #{deploy_to}"
#   end
  
  # desc "Restart the application"
  # task :restart, :roles => :app, :except => { :no_release => true } do
  #   run "#{try_sudo} touch #{File.join(latest_release,'tmp','restart.txt')}"
  # end
#  desc "Delete default web site"
#  task :rm_default_site do
#    run "#{try_sudo} rm /etc/apache2/sites-enabled/000-default"
#  end
# end
# before "deploy:assets:precompile", "deploy:copy_in_database_yml"
# after "deploy:update_code","deploy:copy_in_database_yml", "deploy:symlink_to_public", "deploy:restart"
