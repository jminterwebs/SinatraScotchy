class Scotch < ActiveRecord::Base
  has_many :user_scotches
  has_many :users, through: :user_scotches
end
