class Scotch < ActiveRecord::Base
  has_many :user_scotches
  has_many :users, through: :user_scotches
  belongs_to :distiller
  has_many :comments

  has_many :scotch_flavors
  has_many :flavors, through: :scotch_flavors


  def slug
    name.downcase.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    Scotch.all.find{|scotch| scotch.slug == slug}
  end

end
