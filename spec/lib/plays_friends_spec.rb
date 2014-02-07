require 'spec_helper'
require_relative '../../lib/environment'
require_relative '../../lib/database'

describe "Joining plays with friends" do
  before(:each) do
    Environment.test_prepare
    `./game add 'Shadows Over Camelot' --min 2 --max 7 --time 90 --desc 'Description of game' --environment test`
    @db = Environment.connect_to_database
  end

  context "With valid input" do
    describe "Adding plays" do
      it "Should accept a play with a single friend" do
        command = "./game play 'Shadows Over Camelot' --friends 'John Doe' --environment test"
        expected_output = "You played Shadows Over Camelot with John Doe"
        get_output(command).should == expected_output
      end

      it "Should accept a play with a two friends" do
        command = "./game play 'Shadows Over Camelot' --friends 'John Doe, Jane Doe' --environment test"
        expected_output = "You played Shadows Over Camelot with John Doe and Jane Doe"
        get_output(command).should == expected_output
      end

      it "Should accept a play with a more than two friends" do
        command = "./game play 'Shadows Over Camelot' --friends 'John Doe, Jane Doe, Shigeru Miyamoto' --environment test"
        expected_output = "You played Shadows Over Camelot with John Doe, Jane Doe and Shigeru Miyamoto"
        get_output(command).should == expected_output
      end

      it "Should save a record for each friend in a single play of a game" do
        `./game play 'Shadows Over Camelot' --friends 'John Doe, Jane Doe, Shigeru Miyamoto' --environment test`
         statement = "INNER JOIN plays_friends ON friends.id = plays_friends.friends_id
                      INNER JOIN plays ON plays_friends.plays_id = plays.id
                      INNER JOIN games ON plays.game_id = games.id"
        friends = Friend.joins(statement).where(games: {name: "Shadows Over Camelot"})
        friends.length.should be 3
      end
    end
  end

  context "With invalid input" do
    describe "Adding plays" do
      it "Should not accept a game with no friends" do
        command = "./game play 'Shadows Over Camelot' --environment test"
        expected_output = "You must provide the name of a game and at least one friend"
        get_output(command).should == expected_output
      end

      it "Should not accept a game with no game" do
        command = "./game play --friends 'John Doe' --environment test"
        expected_output = "You must provide the name of a game and at least one friend"
        get_output(command).should == expected_output
      end

      it "Should return an error if game not in database" do
        command = "./game play 'Random Game Name' --friends 'John Doe' --environment test"
        expected_output = "Game not recognized"
        get_output(command).should == expected_output
      end
    end
  end
end
