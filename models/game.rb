require_relative '../lib/options'
require_relative '../lib/environment'
require_relative '../lib/hash_patch'
require_relative '../lib/crud_functions'

class Game
  attr_accessor :name, :min_players, :max_players, :description, :in_collection, :playing_time
  attr_reader :id, :errors
  extend CrudFunctions

  def initialize attributes = {}
    attributes = attributes.symbolize_keys
    [:id, :name, :min_players, :max_players, :description, :in_collection, :playing_time].each do |attr|
      self.send("#{attr}=", attributes[attr])
    end
    self.extend(CrudFunctions)
    self.create_methods
  end

  def self.create options = {}
    game = self.new(options)
    game if game.save
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

  def update_attributes(attrs)
    attrs.keys.each do |attr|
      self.send("#{attr}=", attrs[attr]) unless attr == :environment
    end
    self.save
  end

  def self.find_by_players(number_of_players)
    # number_of_players = number_of_players.to_i
    db = Environment.database_connection
    db.results_as_hash = true
    statement = "SELECT * FROM games WHERE min_players<=#{number_of_players} AND max_players>=#{number_of_players}"
    Environment.logger.info("Executing: " + statement)
    games = db.execute(statement)
    games.map{ |game| game = Game.new(game)}
  end

  def remove
    self.update_attributes({:in_collection => 0})
    self
  end

  def self.remove(name)
    game = Game.new
    game = Game.new(game.find_by_name(name))
    game.remove
  end

  def self.update(name, attrs)
    game = Game.new
    game = Game.new(game.find_by_name(name))
    game = game.update_attributes(attrs)

  end

  def valid?
    @errors = []
    @errors << 'Name must be at least one character' unless name.to_s.length > 0
    @errors << 'Minimum players must be greater than zero' unless min_players.to_i > 0
    @errors << 'Max players must be greater than zero' unless max_players.to_i > 0
    @errors << 'Playing time must be greater than zero' unless playing_time.to_i > 0
    return false unless errors.empty?
    true
  end

  private
  def id=(id)
    @id = id
  end

  def update_record
    db = Environment.database_connection
    db.results_as_hash = true
    statement = "UPDATE games SET name='#{name}', min_players='#{min_players}', max_players='#{max_players}', description='#{description}', playing_time='#{playing_time}', in_collection='#{in_collection}' WHERE id='#{id}'"
    Environment.logger.info("Executing: " + statement)
    db.execute(statement).first
    self
  end

  def create_record
    db = Environment.database_connection
    db.results_as_hash = true
    statement = "INSERT INTO games(name, min_players, max_players,
                 description, playing_time, in_collection
                 ) VALUES('#{name}', '#{min_players}',
                          '#{max_players}', '#{description}', '#{playing_time}', 1)"
    Environment.logger.info("Executing CREATE: " + statement)
    db.execute(statement)
    self.id = db.last_insert_row_id
    db.results_as_hash = false
    self.in_collection = db.execute("SELECT in_collection FROM games WHERE id=#{self.id} ").first.first
    self
  end


end