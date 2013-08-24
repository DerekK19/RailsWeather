role :web, "manderley"							# Your HTTP server, Apache/etc
role :app, "manderley"							# This may be the same as your `Web` server
#role :db,  "mysqlserver", :primary => true		# This is where Rails migrations will run
#role :db,  "mysqlserver"

set(:deploy_to) { "/Users/Shared/Sites/Rails/weather" }
set :use_sudo, false

ssh_options[:forward_agent] = true
