require_relative '../lib/options'
require_relative '../lib/environment'
require_relative '../lib/hash_patch'
require_relative '../lib/crud_functions'

class Game < ActiveRecord::Base
  validates_presence_of :name, :min_players, :max_players, :playing_time
  validates_uniqueness_of :name
  validates_numericality_of :min_players, :max_players, :playing_time
  before_save :set_in_collection

  def self.find_by_players number_of_players
    Game.where("min_players <= #{number_of_players} AND max_players >= #{number_of_players}")
  end

  def remove
    update_attributes({in_collection: 0})
  end

  private

  def set_in_collection
    self.in_collection ||= 1
  end
end