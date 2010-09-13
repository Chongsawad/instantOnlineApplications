class Site < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  
  def deploy_on_background(user, project, site)
    puts "\n\n\n\n\n\n Deploying!…Enqueue to Delayed_job \n\n\n\n\n\n"
    Delayed::Job.enqueue(DeployingJob.new(user, project, site))
  end
  
  def clean_database(site)
    
  end

  def uninstall(site)
    puts "\n\n\n----------- SITE_DESTROYING -----------\n\n\n"
    puts "PATH = #{site.path}"
    puts "APPNAME=#{site.user_id}_#{site.name}"
    if system("sh -c 'cd #{site.path}/current/; cap APPNAME=#{site.user_id}_#{site.name} database:drop;'")
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
