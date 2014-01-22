require_relative 'validate'

class Game
  def self.add options
    Validate.has_required_options(options, "Add game", "min", "max", "time")
    print "Added #{options[:name]}. #{options[:min]}-#{options[:max]} players, "
    puts "#{options[:time]} minutes"
    puts options[:desc] if options.include?(:desc)
  end

  def self.update options
    puts "update #{options}"
  end

  def self.remove options
    puts "remove #{options}"
  end
end
