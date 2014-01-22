#!/usr/bin/env ruby
# -*- ruby -*-

require 'rake/testtask'
Rake::TestTask.new() do |t|
  t.pattern = "test/test_*.rb"
end

desc "Run tests"
task :default => :test

task :bootstrap_database do
  require 'sqlite3'
  require_relative 'lib/environment'
  database = Environment.database_connection("production")
  create_tables(database)
end

task :test_prepare do
  require 'sqlite3'
  require_relative 'lib/environment'
  File.delete("db/grocerytracker_test.sqlite3")
  database = Environment.database_connection("test")
  create_tables(database)
end

def create_tables(database_connection)
  database_connection.execute("CREATE TABLE games (id INTEGER PRIMARY KEY AUTOINCREMENT,
                                                   name varchar(100),
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
                                                     name varchar(60))")
end