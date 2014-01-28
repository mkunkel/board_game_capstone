require 'sqlite3'

class Database < SQLite3::Database
  def self.connection environment
    @connection ||= Database.new("db/boardgametracker_#{environment}.sqlite3")
  end

  def self.create_tables(database_connection)
    database_connection.execute("CREATE TABLE games (id INTEGER PRIMARY KEY AUTOINCREMENT,
                                                     name varchar(100) UNIQUE,
                                                     min_players integer,
                                                     max_players integer,
                                                     description text,
                                                     playing_time integer,
                                                     in_collection boolean)")

    database_connection.execute("CREATE TABLE plays (id INTEGER PRIMARY KEY AUTOINCREMENT,
                                                     date DATETIME DEFAULT CURRENT_TIMESTAMP,
                                                     notes text,
                                                     game_id integer)")

    database_connection.execute("CREATE TABLE plays_friends (plays_id integer,
                                                             friends_id integer)")

    database_connection.execute("CREATE TABLE friends (id INTEGER PRIMARY KEY AUTOINCREMENT,
                                                       name varchar(60) UNIQUE)")
  end

  def execute(statement)
    Environment.logger.info("Executing: " + statement)
    super(statement)
  end

  def self.bootstrap_database
    database = Environment.database_connection#("production")
    create_tables(database)
  end
end
