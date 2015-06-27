class PolyTreeNode

  attr_reader :value, :parent, :children

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(new_parent)
    @parent.children.delete(self) if @parent
    @parent = new_parent
    @parent.children << self if @parent
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    if @children.include?(child_node)
      child_node.parent = nil
      @children.delete(child_node)
    else
      raise "Not a child"
    end
  end

  def dfs(target)
    return self if self.value == target
    self.children.each do |child|
      result = child.dfs(target)
      return result if result
    end
    nil
  end

  def bfs(target)
    queue = [self]

    until queue.empty?
      current_node = queue.shift
      return current_node if current_node.value == target

      queue += current_node.children
    end

   nil
  end

  # def trace_path_back
    # return [node.value] if node.parent.nil?
    # result = self.parent.trace_path_back
    # result << node.value
  #   path = [self.value]
  #   current_position = self
  #   until current_position.parent.nil?
  #     current_position = current_position.parent
  #     path << current_position.value
  #   end
  #   path.reverse
  # end

  def trace
    this_node = [self.value]
    return this_node if self.parent.nil?
    self.parent.trace + this_node
    # self.parent ? self.parent.trace + [self.value] : [self.value]
  end

end
