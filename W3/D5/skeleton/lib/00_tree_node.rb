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

  def parent=(value)
    @parent = value
    parent.children.push(self) if !parent.nil?
    if self.parent != nil
      self.parent.children.delete(self)
    end
  end

end