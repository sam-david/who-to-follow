require 'twitter'
load 'twitter_config.rb'

class Tweet < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
end
