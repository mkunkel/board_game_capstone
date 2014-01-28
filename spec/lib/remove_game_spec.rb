require 'spec_helper'
require_relative '../../lib/environment'

describe "Removing games" do
  before(:each) do
    Environment.test_prepare
  end

  it "Should mark a game as not in collection" do
    `./game add 'Shadows Over Camelot' --min 2 --max 7 --time 45 --desc 'Description of game' --environment test`
    command = "./game remove 'Shadows Over Camelot' --environment test"
    expected_output = "Shadows Over Camelot has been removed from your collection"
    get_output(command).should == expected_output
  end


end
