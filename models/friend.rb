require_relative '../lib/environment'
require_relative '../lib/string_patch'
require_relative '../lib/crud_functions'

class Friend
  attr_accessor :name
  attr_reader :id, :errors
  extend CrudFunctions

  def initialize name = nil
    @name = name.strip.capitalize_sentence if name
    self
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
        create_record
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