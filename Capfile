require 'bundler/capistrano'
require 'active_support/core_ext' #for blank?


set :application, 'WorldMap'
set :app_type, 'rack'
set :repository, 'git://githuben.intranet.mckinsey.com/ODC-Applications/WorldMap.git'
set :scm, 'git'
set :local_scm_command, "git"
set :scm_command, 'git'
set :scm_verbose, true
set :git_shallow_clone, 1
set :branch, 'master'
set :deploy_via, :copy
set :copy_compression, :zip
set :copy_cache, true
set :copy_exclude, ".git/*"


define_stage :devutility do
  roles[:app].clear
  roles[:web].clear
  roles[:db].clear
  role :app, "dev-utility-lx53.amdc.mckinsey.com", :migrations => true, :primary => true
  role :web, "dev-utility-lx53.amdc.mckinsey.com"
  role :db, "dev-utility-lx53.amdc.mckinsey.com", :primary => true
  set :rake, 'bundle exec rake' 
  set :scm_command, 'git'
end

after "deploy:update_code" do # Run bundle install
  run "ls -al #{fetch(:current_release)}"
  bundle_dir = File.join(fetch(:shared_path), 'bundle')
  args = ["--deployment --quiet"]
  args << "--path #{bundle_dir}"
  args << "--without development test"
  run "cd #{fetch(:current_release)} && bundle install #{args.join(' ')}"
end

after "deploy:update_code" do
  run <<-CMD
  #cd #{current_release} &&
   #RAILS_ENV=#{rails_env} bundle exec rake assets:precompile --trace
  CMD
  #run "cd #{current_release}; RAILS_ENV=#{rails_env} bundle exec rake minify:erb"
end

before "deploy:finalize_update" do
  set :release_path, release_path
  set :current_release, release_path
end



namespace :deploy do
  task :download_assets, :roles => :app, :only => { :primary => true } do
    if(minify_assets)
      started_at = Time.now
      local_copy = "./public"
      assets_path = "#{current_release}/public/assets"

      begin
        system "rm -rf #{local_copy}"
        system "mkdir #{local_copy}"
        print "Downloading assets from app server"
        top.download(assets_path, local_copy, :via => :scp, :recursive => true) do |channel, name, sent, total|
          print "."
        end

      rescue => e
        puts e.message
      ensure
        puts "Completed copying assets to deployer in #{(Time.now - started_at)}"
      end
    end
  end
end

namespace :deploy do
  task :upload_assets, :roles => :asset do
    if(minify_assets)
      started_at = Time.now
      local_copy = "./public/assets"

      begin
        run "rm -rf #{asset_server_root}"
        run "mkdir #{asset_server_root}"
        #run "mkdir temp"
        print "Uploading assets from app server"
        top.upload(local_copy, "#{asset_server_root}", :via => :scp, :recursive => true) do |channel, name, sent, total|
          print "."
        end
        run "rm -rf local_copy"
      rescue => e
        puts e.message
      ensure
        puts "Completed deployment to asset servers in #{(Time.now - started_at)}"
      end
    end
  end
end



