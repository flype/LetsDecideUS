set :application, "letsdecide.us"
set :domain,      "root@mallorca.r09.railsrumble.com"
set :deploy_to,   "/var/www/rumble/#{application}"

role :app, domain
role :web, domain
role :db,  domain, :primary => true

# set :gateway, "root@lab.n2kp3.com"
set :runner, "root"
# set :ssh_options, {:forward_agent => true}
# default_run_options[:pty] = true
set :use_sudo,  false

set :repository,  "git@github.com:railsrumble/rr09-team-106.git"
set :scm, "git"
set :repository_cache, "git_cache"
set :deploy_via, :remote_cache
set :password, ""

set :branch, "master"
set :scm_verbose, true 
set :scm_passphrdase, "" #This is your custom users password
set :user, "root"

before 'deploy:symlink', 'symlink_files'
after "deploy:symlink", "deploy:update_crontab"
after "deploy:symlink", "deploy:restart"

task :symlink_files,  :except => { :no_release => true }  do
  run "ln -nfs #{deploy_to}/shared/config/database.yml #{release_path}/config/database.yml"
  run "ln -nfs #{deploy_to}/shared/db/schema.rb #{release_path}/db/schema.rb"
  run "ln -nfs #{deploy_to}/shared/config/config.yml #{release_path}/config/config.yml"
  
end

namespace :deploy do
  desc "Update the crontab file"
  task :update_crontab, :roles => :db do
    run "cd #{current_path} && whenever --update-crontab #{application}"
  end

  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end
end
