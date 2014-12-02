require 'twitter'
require 'dotenv'
Dotenv.load

class Category < ActiveRecord::Base
  has_many :tweets
end

