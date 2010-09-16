class Site < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  validates_presence_of :name
  
  def validate_site_name(string)
    if string =~ /^([0-9a-zA-Z_]{4,12})$/
      puts "Validate"
      return true
    else
      puts "Not validate"
      return false
    end
  end
  
  def deploy_on_background(user, project, site)
    puts "\n\n\n\n\n\n Deploying!…Enqueue to Delayed_job \n\n\n\n\n\n"
    Delayed::Job.enqueue(DeployingJob.new(user, project, site))
  end
  
  def clean_database(site)
    
  end
  
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
  
  def uninstall(site)
    puts "\n\n\n----------- SITE_DESTROYING -----------\n\n\n"
    puts "PATH = #{site.path}"
    puts "APPNAME=#{site.user_id}_#{site.name}"
    if system("sh -c 'cd #{site.path}/current/; cap USER=#{site.user.id} APPNAME=#{site.user_id}_#{site.name} database:drop;'")
      puts "\n----------- Delete Database : #{site.user_id}_#{site.name} -----------\n"
      if system("sh -c 'test -e #{RAILS_ROOT}/site_info/#{current_user.id}_#{site.name}.*'")
        system("sh -c 'rm -Rf #{RAILS_ROOT}/site_info/#{current_user.id}_#{site.name}.*'")
        puts "\n----------- Delete #{RAILS_ROOT}/site_info/#{current_user.id}_#{site.name} -----------\n"
        if system("sh -c 'test -e #{site.path}/'")
          system("sh -c 'rm -Rf #{site.path}'")
          puts "\n----------- Delete #{site.path}   -----------\n"
          return true
        else
          puts "\n----------- Cannot delete application root path --> #{site.path}   -----------\n"
          flash[:warning] = "Cannot delete application root path --> #{site.path}"
          return false
        end
      else
        puts "\n----------- Cannot delete sub-domain the confinguration file --> #{RAILS_ROOT}/site_info/#{current_user.id}_#{site.name} -----------\n"
        return false
      end
    else  
      
    puts "\n----------- Cannot delete Database : #{site.user_id}_#{site.name} -----------\n"
    return false
    end
  end
end
