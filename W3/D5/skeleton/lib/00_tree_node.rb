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
    # self.parent.children.delete(self)
    @parent = parent
    if !parent.nil? && !self.parent.children.include?(self)
      self.parent.children.push(self)
    end
  end



end