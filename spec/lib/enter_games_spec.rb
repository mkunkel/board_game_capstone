require 'spec_helper'
require_relative '../../lib/environment'

describe "Entering games" do
  before(:each) do
    Environment.test_prepare
  end

  it "Should print valid games" do
    command = "./game add 'Shadows Over Camelot' --min 2 --max 7 --time 45 --desc 'Description of game' --environment test"
    expected_output = "Added Shadows Over Camelot. 2-7 players, 45 minutes\nDescription of game"
    get_output(command).should == expected_output
  end

  it "Should require a name" do
    command = "./game add --min 2 --max 7 --time 45 --desc 'Description of game' --environment test"
    expected_output = "Name can't be blank"
    get_output(command).should == expected_output
  end

  it "Should require options" do
    command = "./game add 'Shadows Over Camelot' --environment test"
    expected_output = "Min players can't be blank\nMin players is not a number\nMax players can't be blank\nMax players is not a number\nPlaying time can't be blank\nPlaying time is not a number"
    get_output(command).should == expected_output
  end

  it "Should require require a time option" do
    command = "./game add 'Shadows Over Camelot' --min 2 --max 7 --environment test"
    expected_output = "Playing time can't be blank\nPlaying time is not a number"
    get_output(command).should == expected_output
  end

  it "Should save a valid game" do
    `./game add 'Shadows Over Camelot' --min 2 --max 7 --time 45 --desc 'Description of game' --environment test`
    Environment.environment = "test"
    result = Game.select("name, min_players, max_players, playing_time, description").first
    result = [result.name, result.min_players, result.max_players, result.playing_time, result.description]
    expected_output = ["Shadows Over Camelot", 2, 7, 45, "Description of game"]
    result.should == expected_output
  end
end
