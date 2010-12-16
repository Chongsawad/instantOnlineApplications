class Project < ActiveRecord::Base
  has_many :sites
  has_many :users, :through => "sites"
  
  has_attached_file :screenshot, :styles => { :showcase => "272x296>" }
  
  def self.search(search)
    if search
      find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end
end
