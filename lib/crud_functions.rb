require_relative 'hash_patch'
module CrudFunctions
  def all
    db = Environment.database_connection
    db.results_as_hash = true
    statement = "SELECT * FROM #{self.name.downcase}s"
    db.execute(statement).map{|hash| self.new(hash.select{|k,v| !k.is_a?(Integer)}.symbolize_keys)}
  end

  def create_methods
    instance_variables.each do |ivar|
      ivar = ivar.to_s.gsub(/@/, '')
      name = "find_by_#{ivar}"
      unless ivar == "errors"
        self.class.send(:define_method, name) { |arg|
          db = Environment.database_connection
          db.results_as_hash = true
          statement = "SELECT id, name, min_players, max_players, description, playing_time, in_collection FROM games WHERE #{ivar}='#{arg}'"
          result = db.execute(statement)[0].remove_invalid

          db.results_as_hash = false
          result.symbolize_keys
        }
      end
    end
  end

  def count
    db = Environment.database_connection
    db.results_as_hash = true
    statement = "SELECT id FROM #{self.name.downcase}s"
    db.execute(statement).length
  end
end