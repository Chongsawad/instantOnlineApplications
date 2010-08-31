# This class will be performed by the result of delayed_job enqueueing
class DeployingJob

  # passing 3 arguments:
  #   user - current_user
  #   project - retrieve project/source path
  #   site - specific information for each jobs
  def initialize(user,project,site)

    puts "Initialize Job Detail"
    @app_name = user.id.to_s() + "_" + site[:name]
    @user_id = user.id
    @site_name = site[:name]
    @app_path = project[:path]
    @user = user[:username]
    @siteId = site[:id]
    @path = site[:path]
  end

  # add sub-domain for nginx web server
  def conf_nginx
    puts "Write Nginx Configuration to conf_domain_path"
    f = File.new("#{RAILS_ROOT}/site_info/#{@app_name}.conf","w")

    @server_conf= <<-EOF 
#------- Begin Sub-Domain site_id=#{@siteId}  -------#

  server {
    listen		80;
    server_name 	#{@site_name}.local;
    root  		#{@path}/current/public;
    passenger_enabled 	on;
  }

#------------------ End Sub-Domain -------------------#"
EOF
    f.puts @server_conf
    f.close

  end

  # method for Delayed_job calling
  def perform
    puts "Info to User"
    
    #Nginx configuration

    @s = Site.find(@siteId)

    self.conf_nginx

    puts "Deploying Job"

    if system("sh -c 'cd #{@app_path}/; cap deploy USER=#{@user_id} APPNAME=#{@app_name};'")

    # Reload nginx after deploying has done
      puts "Reload nginx"

      system("sh -c 'sudo /etc/init.d/nginx reload'")

      puts "\n\n*** Email to User *** \n\n "

      JobMailer.deliver_mail_finished

      puts "\n\n *** Update site status *** \n\n "

      
      @s.status = "Online"
      @s.save

    else
      puts "ERROR while deploying"

      @s.status = "Deploying process Incomplete!"
      @s.save
    end

  end

end

