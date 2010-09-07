class Site < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  
  def deploy(user, project, site)
    Delayed::Job.enqueue(DeployingJob.new(user, project, site))
  end

  def re_deploy
    puts "\n\n\n\n\n\n Re-deploy \n\n\n\n\n\n \n\n\n\n\n\n \n\n\n\n\n\n "
  end
  
  def clean_database
    
  end

  def site_destroy
    
  end
end
