class Rook < Piece
  def initialize(color, pos, board)
    super(color, pos, board)
    @symbol = color == :white ? '♖' : '♜'
  end

  def valid_moves(board)
    potential_moves(board).reject { |end_pos| board.move_into_check?(pos, end_pos) }
  end

  def potential_moves(board)
    moves = []

    # Define the rook's straight line movement
    straight_lines = [[-1, 0], [1, 0], [0, -1], [0, 1]]

    straight_lines.each do |dx, dy|
      1.upto(7) do |step|
        x, y = pos
        move = [x + step * dx, y + step * dy]

        if board.valid_move?(move)
          if board.empty?(move)
            moves << move
          elsif board.enemy?(move, color)
            moves << move
            break
          else
            break
          end
        end
      end
    end

    moves
  end
end