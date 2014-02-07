require 'rubygems'
require 'active_record'
require 'yaml'

project_root = File.dirname(File.absolute_path(__FILE__))
Dir.glob(project_root + "/../models/*.rb").each{|f| require f}

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

  def self.connect_to_database
    connection_details = YAML::load(File.open('config/database.yml'))
    ActiveRecord::Base.establish_connection(connection_details[@@environment])
  end

  # def self.database_connection
  #   Database.connection(@@environment || "production")
  # end

  def self.logger

    @@logger ||= Logger.new("logs/#{@@environment || 'production'}.log")

  end

  def self.send_query query
    @@environment = "test"
    database = Environment.connect_to_database
    # database.results_as_hash = false
    database.execute(query)
  end

  def self.test_prepare
    @@environment = "test"
    database = Environment.connect_to_database
    # database.execute("DELETE FROM games")
    # database.execute("DELETE FROM friends")
    # database.execute("DELETE FROM plays")
    # database.execute("DELETE FROM plays_friends")
    Game.destroy_all
    Friend.destroy_all
    Play.destroy_all
    PlaysFriend.destroy_all
  end
end