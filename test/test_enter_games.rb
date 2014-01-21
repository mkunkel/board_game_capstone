require 'minitest/autorun'
require_relative 'helper.rb'

class TestEnteringGames < MiniTest::Unit::TestCase

  def test_00_valid_game_gets_printed
    command = "./game add 'Shadows Over Camelot' --min 2 --max 7 --time 45 --desc 'Description of game'"
    expected = "Added Shadows Over Camelot. 2-7 players, 45 minutes\nDescription of game"
    assert_command_output expected, command
  end

  def test_01_game_requires_a_name
    command = "./game add --min 2 --max 7 --time 45 --desc 'Description of game'"
    expected = "Must provide a name"
    assert_command_output expected, command
  end
end
