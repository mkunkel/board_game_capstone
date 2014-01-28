class Hash
  def symbolize_keys
    self.keys.each do |key|
      self[(key.to_sym rescue key) || key] = self.delete(key)
    end
    self
  end

  def remove_invalid
    new_hash = self.keep_if { |key, value| !key.is_a?(Integer)}
  end
end