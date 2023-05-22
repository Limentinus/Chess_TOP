class Bishop < Piece
  def initialize(color, pos, board)
    super(color, pos, board)
    @symbol = color == :white ? '♗' : '♝'
  end

  def valid_moves(board)
    moves = []

    # Define the bishop's diagonal movement
    diagonals = [[-1, -1], [-1, 1], [1, -1], [1, 1]]

    diagonals.each do |dx, dy|
      1.upto(7) do |step|
        x, y = position
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