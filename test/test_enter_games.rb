require 'minitest/autorun'
require_relative 'helper.rb'

class TestEnteringGames < MiniTest::Unit::TestCase

  def test_something
    assert_command_output "tsfsda", "cal"
  end
end
