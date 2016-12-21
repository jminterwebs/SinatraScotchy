class Scotch < ActiveRecord::Base
  has_many :user_scotches
  has_many :users, through: :user_scotches
  belongs_to :distiller
  has_many :comments
end
