class Pawn < Piece
  def initialize(color, pos, board)
    super(color, pos, board)
    @symbol = color == :white ? '♙' : '♟︎'
  end

  def valid_moves(board)
    moves = []
    x, y = position
    direction = color == :white ? -1 : 1

    # Pawn can move forward one square if it's not blocked
    move = [x + direction, y]
    moves << move if board.valid_move?(move) && board.empty?(move)

    # Pawn can move forward two squares on its first move if both squares are not blocked
    move = [x + 2 * direction, y]
    moves << move if board.valid_move?(move) && board.empty?(move) && !moved?

    # Pawn can capture an enemy piece one square diagonally in front of it
    [-1, 1].each do |dy|
      move = [x + direction, y + dy]
      moves << move if board.valid_move?(move) && board.enemy?(move, color)
    end

    moves
  end

  def moved?
    # If the pawn is in its starting position, it hasn't moved yet
    (color == :white && position[0] == 6) || (color == :black && position[0] == 1)
  end
end
