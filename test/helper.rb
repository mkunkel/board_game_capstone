def assert_command_output expected, command
  assert_equal expected, `#{command}`.strip
end