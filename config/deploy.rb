require 'bundler/capistrano'
# config valid for current version and patch releases of Capistrano
lock "~> 3.11.0"

server 'dylanschwartz.com', :web, :app, :db, primary: true

set :application, "ae_llc_scheduling"
set :user, 'dylan'
set :group, 'admin'
set :deploy_to, "/home/#{user}/apps/#{application}"

set :scm, 'git'
set :git_enable_submodules, 1
set :deploy_via, :remote_cache
set :repository, "git@github.com:dschwar1/ae-llc.git"
set :branch, 'master'

set :use_sudo, false

# share public/uploads
set :shared_children, shared_children + %w{public/uploads}

# allow password prompt
default_run_options[:pty] = true

#turn on key forwarding
ssh_options[:forward_agent] = true

#keep only the last 5 releases
after 'deploy', 'dploy:cleanup'
after 'deploy:restart', 'deploy:cleanup'

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
  task :symlink_shared do
    # run "ln -s /home/cmuis/apps/cmuis/shared/settings.yml /home/cmuis/apps/cmuis/releases/#{release_name}/config/"
  end
end

before "deploy:assets:precompile", "deploy:symlink_shared"


# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure
