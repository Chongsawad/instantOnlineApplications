class Site < ActiveRecord::Base
  belongs_to :project
  belongs_to :user

  def deploy(user, project, site)
    Delayed::Job.enqueue(DeployingJob.new(user, project, site))
  end

  def re_deploy

  end

  def site_destroy
    
  end
end
