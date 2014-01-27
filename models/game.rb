require_relative '../lib/options'
require_relative '../lib/environment'
require_relative '../lib/hash_patch'
require_relative '../lib/crud_functions'

class Game
  attr_accessor :id, :name, :min_players, :max_players, :description, :in_collection, :playing_time, :environment
  extend CrudFunctions

  def initialize attributes = {}
    [:id, :name, :min_players, :max_players, :description, :in_collection, :playing_time, :environment].each do |attr|
      self.send("#{attr}=", attributes[attr])
    end
  end

  def self.create options = {}
    game = self.new(options)
    game if self.save
  end

  def self.save
    if self.valid?
      if id
        update_record
      else
        create_record
      end
    end
  end

  def update_attributes(attrs)
    attrs.keys.each do |attr|

      self.send("#{attr}=", attrs[attr])

    end
    self.save
  end



  def self.output name
    db = Environment.database_connection(environment)
    db.results_as_hash = true
    statement = "SELECT name, min_players, max_players, description, playing_time FROM games WHERE name='#{name}'"
    result = db.execute(statement)
    db.results_as_hash = false
    result = result[0]
    # puts result
    output = "#{result['name']}. #{result['min_players']}-#{result['max_players']} players, "
    output << "#{result['playing_time']} minutes\n"
    output << result["description"] unless result["description"].empty?
    output
  end

  private
  def self.update_record

    db = Environment.database_connection(environment)
    db.results_as_hash = true
    statement = "UPDATE games SET name='#{name}', min_players='#{min_players}', max_players='#{max_players}', description='#{description}', playing_time='#{playing_time}', in_collection='#{in_collection}' WHERE id='#{id}'"
    db.execute(statement).first
    self
  end

  def self.create_record
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

  def self.valid?
    true if (@name.to_s.length > 0) && (min_players.to_i > 0 ) && (max_players.to_i > 0) && ( playing_time.to_i > 0)
  end

end