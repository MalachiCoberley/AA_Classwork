class MaxIntSet

  attr_reader :store

  def initialize(max)
    @store = Array.new(max, false)
  end

  def insert(num)
    validate!(num)
    self.store[num] = true
  end

  def remove(num)
    validate!(num)
    self.store[num] = false
  end

  def include?(num)
    validate!(num)
    self.store[num]
  end

  private

  def is_valid?(num)
    num < @store.length && num >= 0
  end

  def validate!(num)
    if is_valid?(num)
      return true
    else
      raise "Out of bounds"
    end
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    @store[num % @store.length] << num
  end

  def remove(num)
    @store[num % @store.length].delete(num)
  end

  def include?(num)
    @store[num % @store.length].each {|el| return true if el == num}
    false
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    if !self.include?(num)
      @store[num % @store.length] << num
      @count += 1
    end
  end

  def remove(num)
    if self.include?(num)
      @store[num % @store.length].delete(num)
      @count -= 1
    end
  end

  def include?(num)
    resize! if @count >= @store.length
    @store[num % @store.length].each {|el| return true if el == num}
    false
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    elements = Array.new(@store.length * 2) {Array.new}
    @store.flatten!
    @store.each do |el|
       elements[el % elements.length] << el
    end
    @store = elements
  end

end
