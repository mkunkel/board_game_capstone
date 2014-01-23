require 'spec_helper'
require_relative '../../lib/environment'
require_relative '../../models/game'

describe Game do
  before(:each) do
    Environment.test_prepare
  end

  it "Should save and return games" do
    Game.create({:name => "Shadows Over Camelot", :min => 2, :max => 7, :time => 45, :desc => "Description of game", :environment => "test"})
    Game.read("Shadows Over Camelot", "test").should == "Shadows Over Camelot. 2-7 players, 45 minutes\nDescription of game"
  end

end
