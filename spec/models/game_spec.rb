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
      it "Should initialize an instance of class Game" do
        game = Game.new
        game.class.should be Game
      end
    end

    describe '.find_by_players' do
      it "Should return Games" do
        game = Game.find_by_players(3)
        game[0].class.should be Game
      end

      it "Should return the correct number of games" do
        game1 = Game.new({:name => "Shadows Over Camelot", :min_players => 2, :max_players => 7, :playing_time => 45, :description => "Description of game"})
        game1.save
        game2 = Game.new({:name => "Pandemic", :min_players => 2, :max_players => 4, :playing_time => 60, :description => "Description of game"})
        game2.save
        game3 = Game.new({:name => "Resistance", :min_players => 5, :max_players => 10, :playing_time => 30, :description => "Description of game"})
        game3.save
        games_for_3 = Game.find_by_players(3)
        games_for_3.length.should be 2
      end

    end

    describe ".update" do
      it "Should change a name" do
        @game.save
        game = Game.update("Shadows Over Camelot", {:name => 'Pandemic'})
        game.name.should eq('Pandemic')
      end

      it "Should change multiple attributes" do
        @game.save
        game = Game.update("Shadows Over Camelot", {:name => 'Pandemic', :playing_time => 40})
        attrs = [game.name, game.playing_time]
        attrs.should be == ["Pandemic", 40]
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