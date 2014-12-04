class Category < ActiveRecord::Base
  has_many :tweets
  has_many :users, :through => :tweets
end

