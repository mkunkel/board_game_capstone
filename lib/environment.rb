require_relative 'database'
require 'logger'

class Environment

  @@environment = "production"
  def self.environment= env
    @@environment = env
  end

  def self.database_connection
    Database.connection(@@environment)
  end

  def self.logger
    @@logger ||= Logger.new("logs/#{@@environment}.log")

  end

  def self.send_query query
    database = database_connection
    database.results_as_hash = false
    database.execute(query)
  end

  def self.test_prepare
    database = Environment.database_connection
    database.execute("DELETE FROM games")
  end
end