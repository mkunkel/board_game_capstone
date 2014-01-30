require_relative 'database'
require 'logger'

class Environment

  @@environment ||= "test"
  def self.environment
    @@environment ||= "production"
  end

  def self.environment= env
    @@environment = env
  end

  def self.database_connection
    Database.connection(@@environment || "production")
  end

  def self.logger

    @@logger ||= Logger.new("logs/#{@@environment || 'production'}.log")

  end

  def self.send_query query
    @@environment = "test"
    database = Environment.database_connection
    database.results_as_hash = false
    database.execute(query)
  end

  def self.test_prepare
    @@environment = "test"
    database = Environment.database_connection
    database.execute("DELETE FROM games")
    database.execute("DELETE FROM friends")
  end
end