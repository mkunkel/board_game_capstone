require 'spec_helper'
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
        game.class.should be Game
      end
    end

  end

  context 'instance methods' do
    describe '#save' do
      it "Should save games to the database" do
        @game.save
        Game.count.should be 1
      end
    end

    describe '#remove' do
      it "Should mark game as no longer in collection" do
        @game.save
        @game.remove
        @game.in_collection.should be 0
      end
    end

    describe '#update_attributes'  do
      it "Should change the instance variable values" do
        @game.update_attributes({:name => "Pandemic"})
        @game.name.should eq("Pandemic")
      end
    end

    describe 'valid?' do
      it "should return true if game has required attributes" do
        @game.valid?.should be true
      end

      it "should return false if game doesn't have required attributes" do
        g = Game.new
        g.valid?.should be false
      end

      it "should populate errors on the instance if invalid" do
        g = Game.new
        g.valid?
        g.errors.count.should_not be 0
      end
    end
  end
end