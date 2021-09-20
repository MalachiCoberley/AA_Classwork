class PolyTreeNode

  attr_accessor :parent, :children, :value

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def inspect
    "#<PolyTreeNode: @value=#{value}, @parent=#{parent}, @children=#{children}"
  end

  def parent=(parent)
    old_parents_child = self.parent.children if !self.parent.nil?
    old_parents_child.delete(self) if !old_parents_child.nil?
    @parent = parent
    if !parent.nil? && !self.parent.children.include?(self)
      self.parent.children.push(self)
    end
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    child_node.parent = nil
    raise "Node is not a child" if !self.children.include?(child_node)
  end

  def dfs(target_value)
    return self if self.value == target_value
    return nil if self.children.empty?
    self.children.each do |child|
      var = child.dfs(target_value)
      return var if !var.nil?
    end
    nil
  end
  
  def bfs(target_value)
    return self if self.value == target_value
    array = []
    array << self
    until array.empty?
      
    end
  end

end


# node1 = PolyTreeNode.new('root') 
# node2 = PolyTreeNode.new('child1') 
# node3 = PolyTreeNode.new('child2')

# node2.parent = node1
# node3.parent = node1
# node3.parent = node2