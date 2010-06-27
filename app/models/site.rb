class Site < ActiveRecord::Base
  belongs_to :project
  belongs_to :user

  def ch_site_status
    
  end

end
