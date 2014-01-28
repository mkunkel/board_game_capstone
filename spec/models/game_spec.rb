require 'spec_helper'
require 'pry'
require_relative '../../lib/environment'
require_relative '../../models/game'

describe Game do
  before(:each) do
    Environment.test_prepare
    @game = Game.new({:name => "Shadows Over Camelot", :min_players => 2, :max_players => 7, :playing_time => 45, :description => "Description of game"})
  end

  context 'class methods' do
    describe '.new' do
      it "should initialize an instance of class Game" do
        game = Game.new
        game.class.should == Game
      end
    end
  end

  context 'instance methods' do
    describe '#save' do
      it "Should save games to the database" do
        @game.save
        binding.pry
        Game.count.should == 1
      end
    end

    describe 'valid?' do
      it "should return true if game has required attributes" do
        @game.valid?.should == true
      end

      it "should return false if game doesn't have required attributes" do
        g = Game.new
        g.valid?.should == false
      end

      it "should populate errors on the instance if invalid" do
        g = Game.new
        g.valid?
        g.errors.count.should_not == 0
      end
    end
  end
end