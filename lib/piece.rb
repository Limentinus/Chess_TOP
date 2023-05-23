class Piece
  attr_accessor :pos
  attr_reader :color
  attr_reader :symbol

  def initialize(color, pos, board)
    @color = color
    @pos = pos
    @board = board
  end

  def valid_move?(end_pos)
    raise NotImplementedError, "Subclasses must define 'valid_move?'."
  end

  def to_s
    symbol.to_s
  end
end