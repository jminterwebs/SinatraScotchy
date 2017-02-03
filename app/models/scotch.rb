class Scotch < ActiveRecord::Base
  has_many :user_scotches
  has_many :users, through: :user_scotches
  has_many :comments
  has_many :scotch_flavors
  has_many :flavors, through: :scotch_flavors
  validates :name, :age, :abv,  presence: true
  validates :name, uniqueness: { scope: [:age, :abv] }




  def slug
    name.downcase.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    Scotch.all.find{|scotch| scotch.slug == slug}
  end

end
