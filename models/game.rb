require_relative '../lib/options'
require_relative '../lib/environment'
require_relative '../hash_patch'
require_relative '../lib/cruddy_functions'
require "sqlite3"
require 'pry'

class Game
  extend CruddyFunctions

  attr_accessor :id, :name, :min_players, :max_players, :description, :in_collection, :playing_time

  def initialize attributes = {}
    [:id, :name, :min_players, :max_players, :description, :in_collection, :playing_time].each do |attr|
      self.send("#{attr}=", attributes[attr])
    end
  end

  def self.create options = {}
    obj = self.new(options)
    return obj if obj.save
  end

  def self.find(id)
    environment = "production"
    db = Environment.database_connection(environment)
    db.results_as_hash = true
    statement = "SELECT id, name, min_players, max_players, description, playing_time, in_collection FROM games WHERE id='#{id}'"
    g = Game.new(db.execute(statement).first.select{|k,v| !k.is_a?(Integer)}.symbolize_keys)
  end

  def save
    if valid?
      if id
        update_record
      else
        create_record
      end
    end
  end

  def self.count
    all.count
  end

  def in_collection?
    in_collection == "true" ? true : false
  end

  def self.in_collection
    all.select{|x| x.in_collection? == true }
  end

  def remove_from_collection
    self.in_collection = "false"
    self.save
  end

  def self.find_by_name(name)
    all.select{|x| x.name == name}.last
  end

  def update_attributes(attrs)
    attrs.keys.each do |attr|
      unless attr == :environment
        self.send("#{attr}=", attrs[attr])
      end
    end
    self.save
  end

  private

  def update_record
    environment = "production"
    db = Environment.database_connection(environment)
    db.results_as_hash = true
    statement = "UPDATE games SET name='#{name}', min_players='#{min_players}', max_players='#{max_players}', description='#{description}', playing_time='#{playing_time}', in_collection='#{in_collection}' WHERE id='#{id}'"
    db.execute(statement).first
    self
  end

  def create_record
    environment = "production"
    db = Environment.database_connection(environment)
    db.results_as_hash = true
    statement = "INSERT INTO games(name, min_players, max_players,
                 description, playing_time, in_collection
                 ) VALUES('#{name}', '#{min_players}',
                          '#{max_players}', '#{description}', '#{playing_time}', '#{in_collection}')"

    db.execute(statement)
    self.id = db.last_insert_row_id
    self
  end

  def valid?
    true if (name.to_s.length > 0) && (min_players.to_i > 0 ) && (max_players.to_i > 0) && ( playing_time.to_i > 0)
  end

end
