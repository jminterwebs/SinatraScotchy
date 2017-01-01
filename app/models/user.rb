class User < ActiveRecord::Base
  has_secure_password
  has_many :user_scotches
  has_many :scotches, through: :user_scotches

  def slug
    username.downcase.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    User.all.find{|user| user.slug == slug}
  end


end
