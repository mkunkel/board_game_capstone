require 'spec_helper'
require_relative '../../lib/environment'

describe "Suggesting games" do
  before(:each) do
    Environment.test_prepare
    `./game add 'Shadows Over Camelot' --min 2 --max 7 --time 90 --desc 'Description of game' --environment test`
    `./game add 'Pandemic' --min 2 --max 4 --time 60 --desc 'Description of Pandemic' --environment test`
    `./game add 'Resistance' --min 5 --max 10 --time 30 --desc 'Description of Resistance' --environment test`
    `./game add 'Love Letter' --min 2 --max 4 --time 20 --desc 'Description of Love Letter' --environment test`
    `./game add 'War' --min 2 --max 2 --time 1000 --desc 'Description of War' --environment test`

    `./game play 'Shadows Over Camelot' --friends "John Doe, Shigeru Miyamoto" --environment test`
    `./game play 'Pandemic' --friends "John Doe" --environment test`
  end

  context "With valid input" do
    describe "Suggesting games" do
      it "Should list only games none of the players have played" do
        command = "./game suggest --friends 'John Doe, Jane Doe, Shigeru Miyamoto' --environment test"
        expected_output = "Suggested game:\nLove Letter"
        get_output(command).should == expected_output
      end


      it "Should list games in alphabetical order" do
        command = "./game suggest --friends 'Jane Doe, Shigeru Miyamoto' --environment test"
        expected_output = "Suggested games:\nLove Letter\nPandemic\nWar"
        get_output(command).should == expected_output
      end


      it "Should not list games that are no longer in the collection" do
        `./game remove 'War' --environment test`
        command = "./game suggest --friends 'Jane Doe, Shigeru Miyamoto' --environment test"
        expected_output = "Suggested games:\nLove Letter\nPandemic"
        get_output(command).should == expected_output
      end

      it "Should not list games if all have been played" do
        `./game remove 'Pandemic' --environment test`
        `./game remove 'Resistance' --environment test`
        `./game remove 'Love Letter' --environment test`
        `./game remove 'War' --environment test`
        command = "./game suggest --friends 'John Doe, Shigeru Miyamoto' --environment test"
        expected_output = "No games match that criteria"
        get_output(command).should == expected_output
      end
    end
  end

  context "With invalid input" do
    describe "Providing no players" do
      it "Should return an error" do
        command = "./game suggest --environment test"
        expected_output = "You must provide at least one friend"
        get_output(command).should == expected_output
      end
    end
  end

end
