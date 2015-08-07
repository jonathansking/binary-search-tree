class BoardSquare
  attr_reader :value, :children, :parent

  def initialize(value, parent)
    @value = value
    @children = []
    @parent = parent
  end

  def create_children
    children_combinations = child_combinations
    children_combinations.each do |c|
      if is_valid?(c)
        child = BoardSquare.new(c, self)
        @children << child
      end
    end
  end

  def child_combinations
    children_combinations = []
    get_combinations(@value.first, @value[1], children_combinations)
    get_combinations(@value[1], @value.first, children_combinations)
    return children_combinations
  end

  def get_combinations(row, col, children_combinations)
    children_combinations << [row + 1, col + 2]
    children_combinations << [row + 1, col - 2]
    children_combinations << [row - 1, col + 2]
    children_combinations << [row - 1, col - 2]
  end

  def is_valid?(child)
    child.all? { |i| i >= 0 && i < 8 }
  end
end

def knight_moves(square_1, square_2)
  path = []
  start_square, end_square = instantiate_squares(square_1, square_2)
  square = breadth_first_search(start_square, end_square)
  path << square_2
  until square.parent.nil?
    path << square.parent.value
    square = square.parent
  end
  p path.reverse
end

def instantiate_squares(square_1, square_2)
  start_square = BoardSquare.new(square_1, nil)
  end_square = BoardSquare.new(square_2, nil)
  return start_square, end_square
end

def breadth_first_search(start_square, end_square)
  queue = [start_square]
  while queue.any?
    square = queue.shift
    return square if square.value == end_square.value
    square.create_children
    square.children.each { |s| queue << s }
  end
end

knight_moves([3,3], [4,3])
knight_moves([0,0], [1,2])
knight_moves([0,0], [3,3])
knight_moves([3,3], [0,0])
