class Knight < Piece
  def initialize(color, pos, board)
    super(color, pos, board)
    @symbol = color == :white ? '♘' : '♞'
  end

  def valid_moves(board)
    potential_moves(board).reject { |end_pos| board.move_into_check?(pos, end_pos) }
  end

  def potential_moves(board)
    moves = []

    # Define the knight's L-shaped movement
    knight_moves = [[-2, -1], [-2, 1], [2, -1], [2, 1], [-1, -2], [-1, 2], [1, -2], [1, 2]]

    knight_moves.each do |dx, dy|
      x, y = pos
      move = [x + dx, y + dy]

      if board.valid_move?(move) && (board.empty?(move) || board.enemy?(move, color))
        moves << move
      end
    end

    # moves.reject! { |end_pos| board.move_into_check?(pos, end_pos) }
    moves
  end
end
