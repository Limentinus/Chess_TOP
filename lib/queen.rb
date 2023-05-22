class Queen < Piece
  def initialize(color, position)
    super(color, position)
    @symbol = color == :white ? '♕' : '♛'
  end

  def valid_moves(board)
    # The queen's valid moves are a combination of the rook's and bishop's
    Rook.new(color, position).valid_moves(board) + Bishop.new(color, position).valid_moves(board)
  end
end


