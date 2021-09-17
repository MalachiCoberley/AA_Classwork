class PolyTreeNode

  attr_reader :parent, :children, :value

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(value)
    parent = value
    parent.children.push(self) if !parent.nil?
  end

end