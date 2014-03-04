require 'bundler/capistrano'
require 'rvm/capistrano'
set :whenever_command, "bundle exec whenever"
require "whenever/capistrano"

set :rvm_ruby_string, 'ruby-2.0.0-p353' 
set :rvm_type, :system

set :application, "stepped_care_reboot"
set :repository, "git@github.com:nupmmarkbegale/#{application}.git"
set :scm, :git

ssh_options[:forward_agent] = true
default_run_options[:pty] = true

set :branch, "master"

set :deploy_to, "/var/www/html/src/#{application}"

set :use_sudo, false

set(:bundle_flags) { "--path=#{deploy_to}/shared/gems" }

server "deploy@cbits-railsapps.nubic.northwestern.edu", :web, :db, :primary => true                          # Your HTTP server, Apache/etc

before "deploy", "deploy:create_vhost"

before "bundle:install" do
  run "cd #{fetch(:latest_release)} && bundle config build.pg --with-pg-config=/usr/pgsql-9.3/bin/pg_config"
end

after "bundle:install", "deploy:migrate"
after "deploy:set_owner", "deploy:restart"

namespace :db do
  task :db_config, :except => { :no_release => true }, :role => :app do
    run "cp -f ~/#{application}/config/database.yml #{release_path}/config/database.yml"
  end
end

before "deploy:migrate", "db:db_config"

task :copy_secret_token, :except => { :no_release => true }, :role => :app do
  run "cp -f ~/#{application}/config/initializers/secret_token.rb #{release_path}/config/initializers/secret_token.rb"
  run "cp -f ~/#{application}/config/initializers/devise_secret_token.rb #{release_path}/config/initializers/devise_secret_token.rb"
end

task :copy_production_config, :except => { :no_release => true }, :role => :app do
  run "cp -f ~/#{application}/config/environments/production.rb #{release_path}/config/environments/production.rb"
end

before "deploy:migrate", "copy_secret_token"
after "deploy:migrate", "copy_production_config"

namespace :deploy do
  task :start do ; end
  task :stop do ; end

  task :httpd_graceful do
    run "sudo service httpd restart"
  end

  task :set_owner do
    run "sudo chgrp -R apache #{deploy_to}"
  end

  task :create_vhost, :roles => :web do
    vhost_config =<<-EOF
<VirtualHost *:80>
  ServerName steppedcare.northwestern.edu

  DocumentRoot #{deploy_to}/current/public
  RailsBaseURI /
  PassengerDebugLogFile /var/log/httpd/passenger.log

    <Directory #{deploy_to}/current/public >
      Allow from all
      Options -MultiViews
    </Directory>
</VirtualHost>
    EOF
    put vhost_config, "/etc/httpd/conf.d/#{application}.conf"
  end

  task :restart, :roles => :web, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
