require_relative '../lib/environment'

class PlaysFriend < ActiveRecord::Base
  belongs_to :plays
  belongs_to :friends
  validates_presence_of :plays_id, :friends_id
end