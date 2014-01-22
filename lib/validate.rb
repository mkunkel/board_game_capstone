class Validate
  def self.has_required_options options, title, *args
    missing = []
    args.each { |arg|
      missing << arg unless options.include?(arg.to_sym)
    }
    unless missing.empty?
      puts "#{title} requires additional options. You left out the following:"
      missing.each{|option| puts "--#{option.to_s}"}
      exit
    end

  end
end