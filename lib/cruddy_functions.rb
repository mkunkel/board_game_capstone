require 'pry'
module CruddyFunctions
  def all
    environment = "production"
    db = Environment.database_connection(environment)
    db.results_as_hash = true
    statement = "SELECT * FROM #{self.name.downcase}s"
    db.execute(statement).map{|hash| self.new(hash.select{|k,v| !k.is_a?(Integer)}.symbolize_keys)}
  end

# binding.pry
# instance_variables.each do |ivar|
#   define_method("find_by_#{ivar}".to_sym) do |val|
#     binding.pry
#   end
# end

end
