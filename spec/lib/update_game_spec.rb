require 'spec_helper'
require_relative '../../lib/environment'

describe "updating games" do
  before(:each) do
    Environment.test_prepare
  end

  it "Should change only the attributes offered" do
    `./game add 'Shadows Over Camelot' --min 2 --max 7 --time 45 --desc 'Description of game' --environment test`
    command = "./game update 'Shadows Over Camelot' --time 90 --environment test"
    expected_output = "Updated Shadows Over Camelot. 2-7 players, 90 minutes\nDescription of game"
    get_output(command).should == expected_output
  end

  it "Should be able to change the name" do
    `./game add 'Shadows Over Camelot' --min 2 --max 7 --time 45 --desc 'Description of game' --environment test`
    command = "./game update 'Shadows Over Camelot' --name Pandemic --environment test"
    expected_output = "Updated Pandemic. 2-7 players, 45 minutes\nDescription of game"
    get_output(command).should == expected_output
  end

end
