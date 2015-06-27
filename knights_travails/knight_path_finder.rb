require 'set'
require '../tree/lib/00_tree_node'
require 'byebug'

class KnightPathFinder
  attr_reader :visited, :root

  def initialize(start_pos)
    @root = PolyTreeNode.new(start_pos)
    @visited = Set.new
    @visited << start_pos
    build_move_tree
  end

  def inspect
    nil
  end

  def new_move_positions(position)
    moves = KnightPathFinder.valid_moves(position)
    moves.select! {|pos| !visited.include?(pos) }
    @visited += moves
    moves
  end

  def build_move_tree
    queue = [@root]
    until queue.empty?
      current_node = queue.shift
      new_moves = new_move_positions(current_node.value)

      new_moves.each do |move|
        node = PolyTreeNode.new(move)
        node.parent = current_node
        @visited << move
        queue << node
      end
    end
  end

  def find_path(target)
    target_position = @root.bfs(target)
    target_position.trace
  end

  private

  def self.valid_moves(pos)
    row, col = pos
    ops = [ [2, 1], [2, -1], [-2, -1], [-2, 1],
            [-1, -2], [-1, 2], [1, -2], [1, 2]
          ]
    possible = ops.map { |x, y| [row + x, col + y] }
    possible.select { |pos| pos[0].between?(0, 7) && pos[1].between?(0, 7) }
  end

end
