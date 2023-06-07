class Pawn < Piece
  def initialize(color, pos, board)
    super(color, pos, board)
    @symbol = color == :white ? '♙' : '♟︎'
  end

  def valid_moves(board)
    potential_moves(board).reject { |end_pos| board.move_into_check?(pos, end_pos) }
  end

  def potential_moves(board)
    moves = []
    x, y = @pos
    direction = color == :white ? -1 : 1

    # Pawn can move forward one square if it's not blocked
    one_square_move = [x + direction, y]
    moves << one_square_move if board.valid_move?(one_square_move) && board.empty?(one_square_move)

    # Pawn can move forward two squares on its first move if both squares are not blocked
    two_square_move = [x + 2 * direction, y]
    moves << two_square_move if !moved? && board.valid_move?(two_square_move) && board.empty?(one_square_move) && board.empty?(two_square_move)

    # Pawn can capture an enemy piece one square diagonally in front of it
    [-1, 1].each do |dy|
      move = [x + direction, y + dy]
      moves << move if board.valid_move?(move) && board.enemy?(move, color)
    end

    # moves.reject! { |end_pos| board.move_into_check?(pos, end_pos) }
    moves
  end

  def moved?
    # If the pawn is in its starting position, it hasn't moved yet
    !((color == :white && pos[0] == 6) || (color == :black && pos[0] == 1))
  end
  
end
