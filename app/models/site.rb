class Site < ActiveRecord::Base
  belongs_to :deployment
  belongs_to :project
  belongs_to :user
  
  validates_presence_of :name
  
  # Regular Expression
  # prepair for generate sitename
  def validate_site_name(string)
    if string =~ /^([0-9a-zA-Z_]{4,12})$/
      puts "Validate"
      return true
    else
      puts "Not validate"
      return false
    end
  end
  
  def reload_service
    puts "Reload Nginx"
    if `sudo /etc/init.d/nginx reload`
      puts "Reload Nginx Successful"
      return true
    else
      puts "Cannot reload Nginx"
      return false
    end
  end

  # Enqueue job to delayed job 
  # delayed job automated manage queue and install application by itselves
  def deploy_on_background(site)

    puts "\n\n\n\n\n\n Deploying!…Enqueue to Delayed_job \n\n\n\n\n\n"

    Delayed::Job.enqueue(DeployingJob.new(site))

  end
  
  def uninstalling_on_fire(site)

    puts "\n\n\n\n\n\n Uninstalling!…Enqueue to Delayed_job \n\n\n\n\n\n"

    Delayed::Job.enqueue(UninstallingJob.new(site))

  end

  # Find all tables in its application database
  def clean_database(site)
    site.status = "Cleaning database"

    Delayed::Job.enqueue(CleaningJob.new(site))
  end
  

  # Drop database of its application site
  def drop_db(site)

    puts "\n----------- Drop #{site.name}_production   -----------\n"
    
    @app_name = site.user.id.to_s()+'_'+site.name

    if system("sh -c 'cd #{site.path}/current/; cap APPNAME='#{site.user.id}_#{site.name}' USER=#{site.user.id} database:drop;'")

      system("sh -c 'cd #{site.path}/; cap deploy USER=#{site.user.id} APPNAME='#{@app_name}'")

    else
      puts "\n----------- Cannot Drop #{site.user.id}_#{site.name}_production   -----------\n"

      `cd #{site.path}/current/`

      `cap APPNAME=#{site.user.id}_#{site.name} database:drop`
    end
  end
  
  def remove_subdomain_conf(site)

    if system("sh -c 'test -e #{RAILS_ROOT}/site_info/#{site.user.id}_#{site.name}.*'")

      puts "\n----------- Delete #{RAILS_ROOT}/site_info/#{site.user.id}_#{site.name} -----------\n"

      system("sh -c 'rm -Rf #{RAILS_ROOT}/site_info/#{site.user.id}_#{site.name}.*'")

      return true

    else
      puts "\n----------- Cannot delete sub-domain the confinguration file --> #{RAILS_ROOT}/site_info/#{site.user.id}_#{site.name} -----------\n"

      return false
    end
  end

  def remove_site_files
  
  end
  
  # Uninstall its application 
  # Suitable for cleaning its application but not affect to its database.
  def uninstall(site)

    puts "\n\n\n----------- SITE_DESTROYING -----------\n\n\n"

    puts "PATH = #{site.path}"

    puts "APPNAME=#{site.user_id}_#{site.name}"


    # Drop database
    if system("sh -c 'cd #{site.path}/current/; cap USER=#{site.user.id} APPNAME=#{site.user_id}_#{site.name} database:drop;'")

      puts "\n----------- Drop Database : #{site.user_id}_#{site.name} -----------\n"

      # Delete all files of its application
      if system("sh -c 'test -e #{site.path}/'")

        system("sh -c 'rm -Rf #{site.path}'")
        puts "\n----------- Delete #{site.path}   -----------\n"

        # Delete web-server configuration file 
        # stored in deploying tools project [Instant Online Application]
        #remove_subdomain_conf(site) 
        if system("sh -c 'test -e #{RAILS_ROOT}/site_info/#{site.user.id}_#{site.name}.*'")

          system("sh -c 'rm -Rf #{RAILS_ROOT}/site_info/#{site.user.id}_#{site.name}.*'")

          puts "\n----------- Delete #{RAILS_ROOT}/site_info/#{site.user.id}_#{site.name} -----------\n"

          return true

        else
          puts "\n----------- Cannot delete sub-domain the confinguration file --> #{RAILS_ROOT}/site_info/#{site.user.id}_#{site.name} -----------\n"
          flash[:warning] = "Cannot delete sub-domain the confinguration file --> #{RAILS_ROOT}/site_info/#{site.user.id}_#{site.name}"

          return true 
        end
      else
        puts "\n----------- Cannot delete application root path --> #{site.path}   -----------\n"
        flash[:warning] = "Cannot delete application root path --> #{site.path}"

        return false
      end
    else  
    puts "\n----------- Cannot delete Database : #{site.user.id}_#{site.name} -----------\n"

    return "Cannot delete Database : #{site.user.id}_#{site.name} "

    return false

    end
  end
end
