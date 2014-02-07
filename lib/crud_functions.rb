require_relative 'hash_patch'
module CrudFunctions
  # def all
  #   db = Environment.connect_to_database
  #   # db.results_as_hash = true
  #   statement = "SELECT * FROM #{self.name.downcase}s"
  #   db.execute(statement).map{|hash| self.new(hash.select{|k,v| !k.is_a?(Integer)}.symbolize_keys)}
  # end

  def create_methods
    instance_variables.each do |ivar|
      ivar = ivar.to_s.gsub(/@/, '')
      name = "find_by_#{ivar}"
      unless ivar == "errors"
        self.class.send(:define_method, name) { |arg|
          db = Environment.connect_to_database
          # db.results_as_hash = true
          statement = "SELECT * FROM #{self.class.to_s.downcase}s WHERE #{ivar}='#{arg}'"
          result = db.execute(statement)[0]
          unless result.nil?
            result = result.remove_invalid
            result.symbolize_keys
          else
            return nil
          end
        }
      end
    end
  end

  def count
    db = Environment.connect_to_database
    # db.results_as_hash = true
    statement = "SELECT id FROM #{self.name.downcase}s"
    db.execute(statement).length
  end
end