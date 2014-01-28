module CrudFunctions
  def all
    db = Environment.database_connection
    db.results_as_hash = true
    statement = "SELECT * FROM #{self.name.downcase}s"
    db.execute(statement).map{|hash| self.new(hash.select{|k,v| !k.is_a?(Integer)}.symbolize_keys)}
  end

  def count
    db = Environment.database_connection
    db.results_as_hash = true
    statement = "SELECT id FROM #{self.name.downcase}s"
    db.execute(statement).length
  end
end