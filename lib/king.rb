class King < Piece
  def initialize(color, position)
    super(color, position)
    @symbol = color == :white ? '♔' : '♚'
  end

  def valid_moves(board)
    moves = []

    # Define the king's one square movement in all directions
    all_directions = [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]]

    all_directions.each do |dx, dy|
      x, y = position
      move = [x + dx, y + dy]

      if board.valid_move?(move) && (board.empty?(move) || board.enemy?(move, color))
        moves << move
      end
    end

    moves
  end
end