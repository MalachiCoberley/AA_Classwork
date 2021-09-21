require_relative 'tic_tac_toe'

class TicTacToeNode

  #  :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def board
    @board
  end

  def children
    (0...3).each do |i|
      (0...3).each do |j|
        if board[i][j].empty?
          TicTacToeNode.new(@board, @next_mover_mark, [i, j])
        end
      end
    end
  end

  def losing_node?(evaluator)

  end

  def winning_node?(evaluator)

  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
  end
end

# new_var = TicTacToeNode.new(Board.new, :x)
# p new_var