require 'spec_helper'
require_relative '../../lib/environment'

describe "Removing games" do
  before(:each) do
    Environment.test_prepare
  end

  it "Should mark a game as not in collection" do
    `./game add 'Shadows Over Camelot' --min 2 --max 7 --time 45 --desc 'Description of game' --environment test`
    Environment.send_query("UPDATE games SET in_collection='false' WHERE name='Shadows Over Camelot'")
    result = Environment.send_query("SELECT in_collection FROM games WHERE name='Shadows Over Camelot'")
    result[0][0].should == "false"
  end
end
