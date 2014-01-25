require 'spec_helper'
require_relative '../../lib/environment'
require_relative '../../models/game'

describe Game do
  before(:each) do
    Environment.test_prepare
    @game = Game.new
  end

  context 'class methods' do
    describe '.create' do
      context 'with valid options' do
        it 'should create a new instance of game' do
        end

      context 'with invalid options' do
        it 'should return errors' do
        end
      end
      end
    end
  end

  context 'instance methods' do
  end

# it "Should save and return games" do
#   Game.create({:name => "Shadows Over Camelot", :min => 2, :max => 7, :time => 45, :desc => "Description of game", :environment => "test"})
#   Game.read("Shadows Over Camelot", "test").should == "Shadows Over Camelot. 2-7 players, 45 minutes\nDescription of game"
# end

end
