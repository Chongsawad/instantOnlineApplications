# This class will be performed by the result of delayed_job enqueueing
class DeployingJob

  # passing 3 arguments:
  #   user - current_user
  #   project - retrieve project/source path
  #   site - specific information for each jobs
  def initialize(user,project,site)

    puts "Info to User"
    #UserMailer.deliver_mail_waiting

    puts "Initialize Job Detail"
    @app_name = user.id.to_s() + "_" + site[:name]
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
    begin
      #Nginx configuration
      self.conf_nginx

      puts "Deploying Job"
      system("sh -c 'cd #{@app_path}/; cap deploy APPNAME=#{@app_name};'")

      # Reload nginx after deploying has done
      puts "Reload nginx"
      system("sh -c 'sudo /etc/init.d/nginx reload'")
      
      puts " ^_^ Finished Job ^_^ ^_^ Finished Job ^_^ ^_^ Finished Job ^_^"

      puts "\n\n\n *** Email to User *** \n\n\n "
      #UserMailer.deliver_mail_finished
      
      puts "\n\n\n *** Update site status *** \n\n\n "
      self.update_site_status(@siteID)
    rescue 
      puts "\n\n\n\n\n\n\n\n\n\n Roll back \n\n\n\n\n\n\n\n\n"
    end
    
  end

  def update_site_status(id)
    @s = Site.find(id)
    @s.status = "Done"
    if @s.save
      return true
    else
      puts "ERROR while update #{@s.name} record"
      return false
    end
  end
end

