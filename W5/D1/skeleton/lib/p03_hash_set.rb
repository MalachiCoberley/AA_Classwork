class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    resize! if @count >= @store.length
    @store[key.hash % @store.length] << key
    @count += 1
  end

  def include?(key)
    @store[key.hash % @store.length].each {|el| return true if el == key}
    false
  end

  def remove(key)
    return if !self.include?(key)
    @store[key.hash % @store.length].delete(key)
    @count -= 1
    
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
       elements[el.hash % elements.length] << el
    end
    @store = elements
  end
end
