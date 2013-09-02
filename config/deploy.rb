require "rvm/capistrano"
require "capistrano/ext/multistage"
load "config/deploy/progress"

set :stages, ["staging", "production"]
set :default_stage, "staging"

set :rvm_ruby_string, :local                    # use the same ruby as used locally for deployment

before 'deploy:setup', 'rvm:install_rvm'        # update RVM
before 'deploy:setup', 'rvm:install_ruby'       # install Ruby and create gemset (both if missing)

set :keep_releases, 1

set :application, "weather"
set :repository,  "git@github.com:DerekK19/RailsWeather.git"

set :scm, :git

ssh_options[:forward_agent] = true

set :normalize_asset_timestamps, false			# disable asset timestamps update, since rails doesn't use these

after "deploy:restart", "deploy:cleanup"        # clean up old releases on each deploy

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end