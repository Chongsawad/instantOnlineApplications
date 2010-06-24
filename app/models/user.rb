class User < ActiveRecord::Base
  has_many :proejcts, :through => "sites"
  has_many :sites

  # Include default devise modules. Others available are:
  # :http_authenticatable, :token_authenticatable, :confirmable, :lockable, :timeoutable and :activatable
  devise :registerable, :database_authenticatable, #:confirmable,
         :recoverable, :rememberable, :trackable, :validatable
       
  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :password, :password_confirmation
  
end

