require 'rspec'
require_relative '../lib/board'

describe Board do
  subject(:board) { Board.new }

  describe '#initialize' do
    it 'initializes an 8x8 grid' do
      expect(board.grid.size).to eq(8)
      board.grid.each { |row| expect(row.size).to eq(8) }
    end

    it 'places pawns on the board' do
      white_pawns = board.grid[6].all? { |piece| piece.is_a?(Pawn) && piece.color == :white }
      black_pawns = board.grid[1].all? { |piece| piece.is_a?(Pawn) && piece.color == :black }
      expect(white_pawns).to be true
      expect(black_pawns).to be true
    end

    it 'places other pieces correctly on the board' do
      white_pieces = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
      black_pieces = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]

      white_row = board.grid[7].map { |piece| piece.class }
      black_row = board.grid[0].map { |piece| piece.class }
      expect(white_row).to eq(white_pieces)
      expect(black_row).to eq(black_pieces)
    end
  end

  describe '#move_piece' do
    context 'when the move is valid' do
      it 'moves the piece from the start position to the end position' do
        # Write your tests here
      end
    end

    context 'when the move is invalid' do
      it 'raises an error' do
        # Write your tests here
      end
    end
  end

  describe '#in_check?' do
    # Write your tests here
  end

  describe '#in_checkmate?' do
    # Write your tests here
  end

  # Add more tests for other methods in the Board class
end
