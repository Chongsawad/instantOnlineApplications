class Project < ActiveRecord::Base
  has_many :sites
  has_many :users, :through => "sites"
  
  has_attached_file :screenshot, :styles => { :showcase => "272x296>" }
  
  def self.search(search,page)
    paginate :per_page => 6, :page => page, 
             :conditions => ['name LIKE ?', "%#{search}%"], :order => 'name'
  end
end
