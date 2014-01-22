require_relative 'options'

class Game
  def self.add options
    missing = Options.has_required_options(options, "min", "max", "time")
    unless missing.empty?
      puts "Add game requires additional options. You left out the following:"
      missing.each{|option| puts "--#{option.to_s}"}
      return false
    end
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
