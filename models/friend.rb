require_relative '../lib/environment'
require_relative '../lib/string_patch'

class Friend < ActiveRecord::Base
  has_many :plays_friends
  has_many :plays, :through => :plays_friends
  validates_presence_of :name
  validates_uniqueness_of :name

  def initialize attrs = {}
    attrs[:name] = attrs[:name].capitalize_sentence if attrs[:name]
    super
  end
end