class Move
  attr_reader :piece, :start_pos, :end_pos, :board

  def initialize(piece, start_pos, end_pos, board)
    @piece = piece
    @start_pos = start_pos
    @end_pos = end_pos
    @board = board
  end

  def execute
    if piece.valid_move?(end_pos)
      board.move_piece(start_pos, end_pos)
    else
      raise "Invalid move"
    end
  end
end



