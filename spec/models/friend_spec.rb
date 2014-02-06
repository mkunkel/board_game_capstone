require 'spec_helper'
require_relative '../../lib/environment'

describe Friend do
  before(:each) do
    Environment.test_prepare
    @friend = Friend.new({name: "John Doe"})
  end

  context 'class methods' do
    describe '.new' do
      it "Should initialize an instance of class Friend" do
        @friend.class.should be Friend
      end

      it "Should normalize names by capitalizing each part of the name" do
        f = Friend.new({name: "john doe"})
        f.name.should eq("John Doe")
      end
    end
  end

  context 'instance methods' do
    describe '#save' do
      it "Should save friends to the database" do
        @friend.save
        Friend.count.should be 1
      end

      it "Should not save duplicate friends" do
        @friend.save
        new_friend = Friend.new({name: "John Doe"})
        new_friend.save
        @friend.id.should be new_friend.id
      end
    end

    describe 'valid?' do
      it "should return true if Friend has required attributes" do
        @friend.should be_valid
      end

      it "should return false if friend doesn't have required attributes" do
        f = Friend.new
        f.should_not be_valid
      end

      it "should populate errors on the instance if invalid" do
        f = Friend.new
        f.valid?
        f.errors.count.should_not be 0
      end
    end
  end
end