class String
  def capitalize_sentence
    split_string = self.split(" ")
    split_string.map{|word| word.capitalize}.join(" ")
  end
end