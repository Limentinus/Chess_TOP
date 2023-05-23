require 'colorize'
require_relative 'piece'
require_relative 'pawn'
require_relative 'rook'
require_relative 'knight'
require_relative 'bishop'
require_relative 'queen'
require_relative 'king'

class Board
  attr_accessor :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) }
    setup_pieces
  end

  def move_piece(start_pos, end_pos, color)
    raise 'start position is empty' if empty?(start_pos)

    piece = self[start_pos]
    if piece.color != color
      raise 'You must move your own piece'
    elsif !piece.valid_moves(self).include?(end_pos)
      raise 'Piece cannot move to end_pos'
    end

    move_piece!(start_pos, end_pos)
  end

  def valid_move?(pos)
    pos.all? { |coord| coord.between?(0, 7) }
  end

  def empty?(pos)
    self[pos].nil?
  end

  def enemy?(pos, color)
    !empty?(pos) && self[pos].color != color
  end

  private

  def move_piece!(start_pos, end_pos)
    piece = self[start_pos]
    self[end_pos] = piece
    self[start_pos] = nil
    piece.position = end_pos
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(pos, value)
    x, y = pos
    @grid[x][y] = value
  end

  def setup_pieces
    # Setup pawns
    8.times do |i|
      @grid[1][i] = Pawn.new(:black, [1, i], self)
      @grid[6][i] = Pawn.new(:white, [6, i], self)
    end
  
    # Setup other pieces
    pieces = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
    pieces.each_with_index do |piece, i|
      @grid[0][i] = piece.new(:black, [0, i], self)
      @grid[7][i] = piece.new(:white, [7, i], self)
    end
  end
  
end

