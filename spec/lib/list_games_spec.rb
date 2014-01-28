require 'spec_helper'
require_relative '../../lib/environment'

describe "Listing games" do
  before(:each) do
    Environment.test_prepare
    `./game add 'Shadows Over Camelot' --min 2 --max 7 --time 90 --desc 'Description of game' --environment test`
    `./game add 'Pandemic' --min 2 --max 4 --time 60 --desc 'Description of Pandemic' --environment test`
    `./game add 'Resistance' --min 5 --max 10 --time 30 --desc 'Description of Resistance' --environment test`
  end

  it "Should list games for 3 players" do
    command = "./game list '3 players' --environment test"
    expected_output = "Games for 3 players:\nShadows Over Camelot\nPandemic"
    get_output(command).should == expected_output
  end

  it "Should say if no games work with a certain number of players" do
    command = "./game list '11 players' --environment test"
    expected_output = "You do not have any games for 11 players"
    get_output(command).should == expected_output
  end

  it "Should know the difference between player and players" do
    command = "./game list '1 player' --environment test"
    expected_output = "You do not have any games for 1 player"
    get_output(command).should == expected_output
  end

end
