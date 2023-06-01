require 'colorize'
require_relative 'piece'
require_relative 'pawn'
require_relative 'rook'
require_relative 'knight'
require_relative 'bishop'
require_relative 'queen'
require_relative 'king'
require_relative 'input_output'

class Board
  attr_accessor :grid

  def initialize(setup = true)
    @grid = Array.new(8) { Array.new(8) }
    setup_pieces if setup
  end

  def setup_from_fen(fen_str)
    pieces = {
      'p' => Pawn,
      'r' => Rook,
      'n' => Knight,
      'b' => Bishop,
      'q' => Queen,
      'k' => King,
      'P' => Pawn,
      'R' => Rook,
      'N' => Knight,
      'B' => Bishop,
      'Q' => Queen,
      'K' => King
    }

    piece_placement, *rest = fen_str.split(' ') # use only the first part of the FEN string
    rows = piece_placement.split('/')
    rows.each_with_index do |row, i|
    file = 0

      row.chars.each do |char|
        if char.to_i.positive?
          file += char.to_i  # if it's a digit, it represents empty squares, so move the file index
        elsif pieces.include?(char)
          piece_class = pieces[char]
          color = char == char.downcase ? :black : :white
          @grid[i][file] = piece_class.new(color, [i, file], self)
          file += 1
        end
      end
    end
  end
  

  def move_piece(start_pos, end_pos, color)
    raise 'start position is empty' if empty?(start_pos)
  
    piece = self[start_pos]
    
    raise 'You must move your own piece' if piece.color != color
    raise 'Piece cannot move to end_pos' unless piece.valid_moves(self).include?(end_pos)
  
    move_piece!(start_pos, end_pos)
  end
  

  def simulate_move(start_pos, end_pos)
    captured_piece = move_piece!(start_pos, end_pos)
    in_check = in_check?(self[end_pos].color)
    
    # Undo the move
    move_piece!(end_pos, start_pos)
    self[end_pos] = captured_piece
    self[end_pos].position = end_pos if captured_piece

    in_check
  end

  def valid_move?(pos)
    return false unless pos.is_a?(Array)
    return false unless pos.length == 2
    pos.all? { |coord| coord.is_a?(Integer) && coord.between?(0, 7) }
  end
  

  def empty?(pos)
    self[pos].nil?
  end

  def enemy?(pos, color)
    !empty?(pos) && self[pos].color != color
  end

  def in_check?(color)
    king_pos = find_king(color).pos
    enemies = grid.flatten.compact.select { |piece| piece.color != color }

    enemies.any? { |enemy| enemy.valid_moves(self).include?(king_pos) }
  end

  def in_checkmate?(color)
    in_check?(color) && !has_valid_moves?(color)
  end

  def in_stalemate?(color)
    !in_check?(color) && !has_valid_moves?(color)
  end
  
  def has_valid_moves?(color)
    pieces = find_pieces(color)
    pieces.any? do |piece|
      piece.valid_moves(self).any? { |move| valid_move?(move) }
    end
  end

  private

  def find_pieces(color)
    grid.flatten.compact.select { |piece| piece.color == color }
  end

  def find_king(color)
    king = grid.flatten.compact.find { |piece| piece.is_a?(King) && piece.color == color }
    king || (raise 'king not found')
  end

  def move_piece!(start_pos, end_pos)
    piece = self[start_pos]
    captured_piece = self[end_pos] # Added this line to store the captured piece, if any

    self[end_pos] = piece
    self[start_pos] = nil
    piece.pos = end_pos

    # Return the captured piece so that it can be replaced if necessary
    captured_piece
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

