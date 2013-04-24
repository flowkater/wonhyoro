require "bundler/capistrano"
require "delayed/recipes"

set :application, "wonhyoro"

set :scm, :git
set :repository, "git@github.com:flowkater/wonhyoro.git"
set :branch, "master"
set :scm_passphrase, "chjw102"
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

set :eip, "54.249.230.298"

role :web, eip                          # Your HTTP server, Apache/etc
role :app, eip                          # This may be the same as your `Web` server
role :db,  eip, :primary => true # This is where Rails migrations will run

set :user, "ubuntu"
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false
set :rails_env, "production"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true
# ssh_options[:keys] = [File.join(ENV["HOME"], ".ssh", "chjw102"]

set :default_environment, { "PATH" => "$HOME/.rbenv/shims:$HOME/.rbenv/bin:$HOME/.rbenv/versions/1.9.3-p125/bin:$HOME/.rbenv/versions/1.9.3-p125/lib/ruby/gems/1.9.1/gems:$PATH"}

after "deploy", "deploy:cleanup"

namespace :deploy do
  %w[start stop restart].each do |command|
    desc "#{command} unicorn server"
    task command, roles: :app, except: {no_release: true} do
      run "/etc/init.d/unicorn_#{application} #{command}"
    end
  end

  task :setup_config, roles: :app do
    sudo "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{application}"
    sudo "ln -nfs #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_#{application}"
    run "mkdir -p #{shared_path}/config"
    put File.read("config/database.example.yml"), "#{shared_path}/config/database.yml"
    puts "Now edit the config files in #{shared_path}."
  end
  after "deploy:setup", "deploy:setup_config"

  task :symlink_config, roles: :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
  after "deploy:finalize_update", "deploy:symlink_config"

  desc "Make sure local git is in sync with remote."
  task :check_revision, roles: :web do
    unless `git rev-parse HEAD` == `git rev-parse origin/master`
      puts "WARNING: HEAD is not the same as origin/master"
      puts "Run `git push` to sync changes."
      exit
    end
  end
  before "deploy", "deploy:check_revision"
end