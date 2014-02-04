require_relative '../lib/environment'
require_relative '../lib/string_patch'
require_relative '../lib/crud_functions'

class Friend
  attr_accessor :name
  attr_reader :id, :errors
  extend CrudFunctions

  def initialize attrs = {}
    attrs = {} if attrs.nil?
    @name = attrs[:name].strip.capitalize_sentence if attrs[:name]
    @id = attrs[:id] if attrs[:id]
    self.extend CrudFunctions
    self.create_methods
    self
  end

  def self.create options = {}
    friend = self.new(options)
    friend if friend.save
  end

  def valid?
    @errors = []
    @errors << "No name provided" if @name.nil?
    @errors << "Name must be at least 1 character" if !@name.nil? and @name.empty?
    @errors.empty?
  end

  def save
    if valid?
      if id.nil?
        friend = Friend.new(self.find_by_name(@name))
        if friend.id
          self.id = friend.id
          self
        else
          create_record
        end
      end
    end
  end

  def create_record
    db = Environment.database_connection
    db.results_as_hash = true
    statement = "INSERT INTO friends(name) VALUES('#{name}')"
    Environment.logger.info("Executing CREATE: " + statement)
    db.execute(statement)
    self.id = db.last_insert_row_id
    self
  end

  private

  def id= new_id
    @id = new_id
  end
end