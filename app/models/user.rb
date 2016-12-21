class User < ActiveRecord::Base
  has_secure_password
  has_many :user_scotches
  has_many :scotches, through: :user_scotches
  
end
