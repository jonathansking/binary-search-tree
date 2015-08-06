class Node
  attr_accessor :value, :parent, :left_child, :right_child

  def initialize(value, parent)
    @value = value
    @parent = parent
    @left_child = nil
    @right_child = nil
  end
end

class BST
  attr_accessor :root

  def initialize
    @root = nil
  end

  def build_tree(array)
    array.each { |value| insert(@root, value) }
  end

  def insert(node, value)
    if !@root
      @root = Node.new(value, nil)
    elsif greater_value?(node, value)
      node.right_child ? insert(node.right_child, value) :
                         insert_right_child(node, value)
    else
      node.left_child ? insert(node.left_child, value) :
                        insert_left_child(node, value)
    end
  end

  def insert_right_child(node, value)
    node.right_child = Node.new(value, node)
  end

  def insert_left_child(node, value)
    node.left_child = Node.new(value, node)
  end

  def greater_value?(node, value)
    value > node.value
  end

  def breadth_first_search(value)
    queue = [@root]
    while queue.any?
      node = queue.shift
      return node if value == node.value
      queue << node.left_child if node.left_child
      queue << node.right_child if node.right_child
    end
    return "Not in tree"
  end

  def depth_first_search(value)
    stack = [@root]
    while stack.any?
      node = stack.pop
      return node if value == node.value
      stack << node.left_child if node.left_child
      stack << node.right_child if node.right_child
    end
    return "Not in tree"
  end

  def dfs_rec(node, value)
    return node if node.value == value
    dfs_rec(node.left_child, value) if node.left_child
    dfs_rec(node.right_child, value) if node.right_child
  end
end

array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 634, 324]
tree = BST.new
tree.build_tree(array)
puts tree.breadth_first_search(67)
puts tree.depth_first_search(67)
puts tree.dfs_rec(tree.root, 67)
