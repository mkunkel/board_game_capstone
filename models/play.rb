require_relative '../lib/environment'

class Play < ActiveRecord::Base
  has_one :game
  has_many :plays_friends
  has_many :friends, :through => :plays_friends

  validates_presence_of :game_id
  validates_numericality_of :game_id
end