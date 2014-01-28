require 'optparse'

class Options

  def self.parse
    options = {}

    OptionParser.new do |opts|
      opts.banner = "Usage: game [command] [options]"

      opts.on("--min [MIN]", "The minimum number of players") do |min|
        options[:min_players] = min
      end

      opts.on("--max [MAX]", "The maximum number of players") do |max|
        options[:max_players] = max
      end

      opts.on("-t", "--time [TIME]", "The playing time") do |time|
        options[:playing_time] = time
      end

      opts.on("-d", "--desc [DESC]", "The description") do |desc|
        options[:description] = desc
      end

      opts.on("-f", "--friends [FRIENDS]", "A list of friends") do |friends|
        friends = friends.split(',')
        options[:friends] = friends.map{|name| name.strip}
      end

      opts.on("--environment [ENV]", "The software environment") do |env|
        options[:environment] = env
      end

      opts.on("-h", "--help", "Display this help") do
        hidden_switch = "--environment"
        #Typecast opts to a string, split into an array of lines, delete the line
        #if it contains the argument, and then rejoins them into a string
        puts opts.to_s.split("\n").delete_if { |line| line.include?(hidden_switch)}.join("\n")
        exit
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