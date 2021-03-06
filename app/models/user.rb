class User < ActiveRecord::Base
  has_and_belongs_to_many :courses
  has_secure_password
  
  #user with role of 1 is an admin
  def admin?
       self.role == 1
    end  
  
end
