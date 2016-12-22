class Flavor < ActiveRecord::Base
  has_many :scotch_flavors
  has_many :scotches, through: :scotch_flavors

end
