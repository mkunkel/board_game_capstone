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
    expected_output = "Must provide a name"
    get_output(command).should == expected_output
  end

  it "Should require options" do
    command = "./game add 'Shadows Over Camelot' --environment test"
    expected_output = "Add game requires additional options. You left out the following:\n--min\n--max\n--time"
    get_output(command).should == expected_output
  end

  it "Should require require a time option" do
    command = "./game add 'Shadows Over Camelot' --min 2 --max 7 --environment test"
    expected_output = "Add game requires additional options. You left out the following:\n--time"
    get_output(command).should == expected_output
  end

  it "Should save a valid game" do
    `./game add 'Shadows Over Camelot' --min 2 --max 7 --time 45 --desc 'Description of game' --environment test`
    result = Environment.send_query("SELECT name, min_players, max_players, playing_time, description FROM games")
    expected_output = [["Shadows Over Camelot", 2, 7, 45, "Description of game"]]
    result.should == expected_output
  end
end
