class Deployment < ActiveRecord::Base
  has_one :site
  has_many :configParameters
  belongs_to :recipe
end
