class King < Piece
  def initialize(color, pos, board)
    super(color, pos, board)
    @symbol = color == :white ? '♔' : '♚'
  end

  # This is the method you will use when moving the King
  def valid_moves(board)
    potential_moves(board).reject { |end_pos| board.move_into_check?(pos, end_pos) }
  end

  # This is the method you will use when checking if the King is in check
  def potential_moves(board)
    moves = []

    # Define the king's one square movement in all directions
    all_directions = [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]]

    all_directions.each do |dx, dy|
      x, y = pos
      move = [x + dx, y + dy]

      if board.valid_move?(move) && (board.empty?(move) || board.enemy?(move, color))
        moves << move
      end
    end

    moves
  end
end
