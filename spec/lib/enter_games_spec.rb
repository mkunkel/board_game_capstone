require 'spec_helper'
require 'pry'

describe "Entering games" do
  before(:each) do
    test_prepare
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

  it "Should require require options" do
    command = "./game add 'Shadows Over Camelot' --environment test"
    expected_output = "Add game requires additional options. You left out the following:\n--min\n--max\n--time"
    get_output(command).should == expected_output
  end

  it "Should require require options" do
    command = "./game add 'Shadows Over Camelot' --min 2 --max 7 --time 45 --environment test"
    expected_output = "Added Shadows Over Camelot. 2-7 players, 45 minutes"
    get_output(command).should == expected_output
  end

  it "Should require require a time option" do
    command = "./game add 'Shadows Over Camelot' --min 2 --max 7 --environment test"
    expected_output = "Add game requires additional options. You left out the following:\n--time"
    get_output(command).should == expected_output
  end

  it "Should save a valid game" do
    pending
    get_output(command).should == expected_output
  end
end
