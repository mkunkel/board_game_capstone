require 'optparse'

class Options

  def self.parse
    options = { environment: "production" }

    OptionParser.new do |opts|
      opts.banner = "Usage: game [command] [options]"

      opts.on("--min [MIN]", "The minimum number of players") do |min|
        options[:min] = min
      end

      opts.on("--max [MAX]", "The maximum number of players") do |max|
        options[:max] = max
      end

      opts.on("--time [TIME]", "The playing time") do |time|
        options[:time] = time
      end

      opts.on("--desc [DESC]", "The description") do |desc|
        options[:desc] = desc
      end

      opts.on("--friends [FRIENDS]", "A list of friends") do |friends|
        friends = friends.split(',')
        options[:friends] = friends.map{|name| name.strip}
      end

      opts.on("--environment [ENV]", "The software environment") do |env|
        options[:environment] = env
      end
    end.parse!
    options
  end

  def self.has_required_options options, *args
    missing = []
    args.each { |arg|
      missing << arg unless options.include?(arg.to_sym)
    }
    return missing
  end


end