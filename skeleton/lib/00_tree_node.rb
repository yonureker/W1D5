require 'byebug'
class PolyTreeNode

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent
    @parent
  end

  def children
    @children
  end

  def value
    @value
  end

  def parent=(other_node)
    if @parent != nil
      @parent.children.delete(self)
    end

    if other_node != nil
      unless other_node.children.include?(self) 
        other_node.children << self
      end
      @parent = other_node
    else
      @parent = nil
    end
    # unless we're setting parent to nil?
  end

  def add_child(child_node)
    child_node.parent=(self) #child_node.parent = self
  end

  def remove_child(child_node)
    if child_node.parent == nil
      raise "Hey this node does not have a parent"
    else
      child_node.parent=(nil)
    end
  end

  def dfs(target_value)
    return nil if self.nil?
    return self if self.value == target_value

    self.children.each do |child|
      search_result = child.dfs(target_value)
      return search_result unless search_result == nil
    end

    return nil
  end

  def bfs(target_value)
    return self if self.value == target_value

    queue = [self]

    until queue.empty?
      debugger
      current_node = queue.shift
      return current_node if current_node.value == target_value
      current_node.children.each { |child| queue.push(child)}
    end
    return nil
  end
end

