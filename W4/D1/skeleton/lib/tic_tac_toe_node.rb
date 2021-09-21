require_relative 'tic_tac_toe'

class TicTacToeNode

  attr_accessor :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def children
    array = []
    (0...3).each do |i|
      (0...3).each do |j|
        if board[i][j].empty?
          board[i][j] = @next_mover_mark
          if @next_mover_mark == :x
            @next_mover_mark = :o
          else
            @next_mover_mark = :x
          end
          array << TicTacToeNode.new(@board, @next_mover_mark, [i, j])
          @prev_move_pos = board[i][j]
        end
      end
    end
    array
  end

  def losing_node?(evaluator)

  end

  def winning_node?(evaluator)

  end

  # This method generates an array of all moves that can be made after
  # the current move.
end

# new_var = TicTacToeNode.new(Board.new, :x)
# p new_var