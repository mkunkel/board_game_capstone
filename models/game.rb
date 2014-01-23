require_relative '../lib/options'
require_relative '../lib/environment'

class Game
  def self.create options
    missing = Options.has_required_options(options, "min", "max", "time")
    unless missing.empty?
      output = "Add game requires additional options. You left out the following:\n"
      missing.each{|option| output << "--#{option.to_s}\n"}
      output
    else
      require "sqlite3"
      db = Environment.database_connection(options[:environment])
      statement = "INSERT INTO games(name, min_players, max_players,
                   description, playing_time, in_collection
                   ) VALUES('#{options[:name]}', '#{options[:min]}',
                            '#{options[:max]}', '#{options[:desc]}', '#{options[:time]}', 'true')"
      db.execute(statement)
      output = "Added #{options[:name]}. #{options[:min]}-#{options[:max]} players, "
      output << "#{options[:time]} minutes\n"
      output << options[:desc] if options.include?(:desc)
      output
    end
  end

  def self.update

  end

  def self.remove

  end

  def self.read name, environment = "production"
    db = Environment.database_connection(environment)
    db.results_as_hash = true
    statement = "SELECT name, min_players, max_players, description, playing_time FROM games WHERE name='#{name}'"
    result = db.execute(statement)
    result = result[0]
    # puts result
    output = "#{result['name']}. #{result['min_players']}-#{result['max_players']} players, "
    output << "#{result['playing_time']} minutes\n"
    output << result["description"] unless result["description"].empty?
    output
  end


end