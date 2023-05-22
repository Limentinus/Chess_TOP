class Piece
  attr_accessor :pos
  attr_reader :color

  def initialize(color, pos, board)
    @color = color
    @pos = pos
    @board = board
  end

  def valid_move?(end_pos)
    raise NotImplementedError, "Subclasses must define 'valid_move?'."
  end

  def symbol
    raise NotImplementedError, "Subclasses must define 'symbol'."
  end

  def to_s
    symbol.to_s
  end
end