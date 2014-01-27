require 'spec_helper'
require_relative '../../lib/environment'
require_relative '../../models/game'

describe Game do
  before(:each) do
    Environment.test_prepare
  end

  it "Should create a game" do
    game = Game.new({:name => "Shadows Over Camelot", :min => 2, :max => 7, :time => 45, :desc => "Description of game", :environment => "test"})
    game.class.should == Game
  end

  it "Should save games to the database" do
    game = Game.new({:name => "Shadows Over Camelot", :min => 2, :max => 7, :time => 45, :desc => "Description of game", :environment => "test"})
    count_before_save = game.count
    game.save
    game.count.should > count_before_save
  end
end
