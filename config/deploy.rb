require 'sidekiq/capistrano'

set :application, "twitter-monitor.andersonsoares.info"
set :repository,  "git://github.com/andersonsoares/twitter-monitor.git"

set :user, "deploy"
set :use_sudo, false

set :deploy_to, "/home/#{user}/aers/#{application}"

ssh_options[:forward_agent] = true
ssh_options[:keys] = %w(~/.private-key) 


set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

server application, :app, :web, :db, :primary=>true

set :normalize_asset_timestamps, false

after "deploy:update_code","deploy:config_symlink"

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
   run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
  
  task :config_symlink do
    run "cp #{shared_path}/database.yml #{release_path}/config/database.yml"
  end
  
end

