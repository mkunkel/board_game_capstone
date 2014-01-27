require_relative 'database'
require 'logger'
require 'pry'

class Environment

  @@environment = "production"
  def self.environment= env
    puts '-'
    puts env
    puts '-'
    @@environment = env
  end

  def self.database_connection
    Database.connection(@@environment)
  end

  # def self.create_tables(database_connection)
  #   database_connection.execute("CREATE TABLE games (id INTEGER PRIMARY KEY AUTOINCREMENT,
  #                                                    name varchar(100) UNIQUE,
  #                                                    min_players integer,
  #                                                    max_players integer,
  #                                                    description text,
  #                                                    playing_time integer,
  #                                                    in_collection boolean)")

  #   database_connection.execute("CREATE TABLE plays (id INTEGER PRIMARY KEY AUTOINCREMENT,
  #                                                    date DATETIME DEFAULT CURRENT_TIMESTAMP,
  #                                                    notes text,
  #                                                    game_id integer)")

  #   database_connection.execute("CREATE TABLE plays_friends (plays_id integer,
  #                                                            friends_id integer)")

  #   database_connection.execute("CREATE TABLE friends (id INTEGER PRIMARY KEY AUTOINCREMENT,
  #                                                      name varchar(60) UNIQUE)")
  # end

  # def self.bootstrap_database
  #   database = Environment.database_connection#("production")
  #   create_tables(database)
  # end




  def self.logger
    @@logger ||= Logger.new("logs/#{@@environment}.log")

  end

  def self.send_query query
    database = database_connection#("test")
    database.execute(query)
  end

  def self.test_prepare
    database = Environment.database_connection#("test")
    database.execute("DELETE FROM games")
    # @connection = nil
    # db_file = "db/boardgametracker_test.sqlite3"
    # File.delete(db_file) if File.exists?(db_file)
    # create_tables(database)
  end
end