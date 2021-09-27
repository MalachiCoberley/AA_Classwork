class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    hash_sum = 0
    self.each_with_index do |el, i|
      hash_sum += (el + i).hash
    end
    hash_sum
  end
end

class String
  def hash
    hash_sum = 0
    self.each_char.with_index do |char, i|
      hash_sum += (char.ord + i).hash
    end
    hash_sum
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    hash_sum = 0
    self.each do |k, v|
      hash_sum += (char.ord + i).hash
    end
    hash_sum
  end
end
