class User < ActiveRecord::Base
  has_many :tweets
  has_many :categories, :through => :tweets
end
