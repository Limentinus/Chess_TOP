class Knight < Piece
  def initialize(color, position)
    super(color, position)
    @symbol = color == :white ? '♘' : '♞'
  end

  def valid_moves(board)
    moves = []

    # Define the knight's L-shaped movement
    knight_moves = [[-2, -1], [-2, 1], [2, -1], [2, 1], [-1, -2], [-1, 2], [1, -2], [1, 2]]

    knight_moves.each do |dx, dy|
      x, y = position
      move = [x + dx, y + dy]

      if board.valid_move?(move) && (board.empty?(move) || board.enemy?(move, color))
        moves << move
      end
    end

    moves
  end
end
