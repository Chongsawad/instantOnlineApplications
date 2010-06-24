class Project < ActiveRecord::Base
  has_many :sites
  has_many :users, :through => "sites"
  
  has_attached_file :screenshot, :styles => { :showcase => "272x296>" }
end
