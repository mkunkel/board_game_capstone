require 'spec_helper'
require_relative '../../lib/environment'

describe Play do
  before(:each) do
    Environment.test_prepare
    @play = Play.new
  end

  context 'class methods' do
    describe '.new' do
      it "Should initialize an instance of class Play" do
        @play.class.should be Play
      end
    end
  end

  context 'instance methods' do
    describe '#save' do
      it "Should save plays to the database" do
        @play.game_id = 3
        @play.save
        Play.count.should be 1
      end
    end

    describe 'valid?' do
      it "should return true if Play has required attributes" do
        @play.game_id = 3
        @play.should be_valid
      end

      it "should return false if friend doesn't have required attributes" do
        p = Play.new
        p.should_not be_valid
      end

      it "should populate errors on the instance if invalid" do
        p = Play.new
        p.valid?
        p.errors.count.should_not be 0
      end
    end
  end
end