require_relative 'options'
require_relative 'environment'

class Game


  def self.update options
    puts "update #{options}"
  end

  def self.remove options
    puts "remove #{options}"
  end
end
