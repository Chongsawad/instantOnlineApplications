class Recipe < ActiveRecord::Base
  has_one :deployment
  has_one :project
end
