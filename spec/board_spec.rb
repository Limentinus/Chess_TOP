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

  describe "#move_piece" do
    let(:board) { Board.new }

    context "when start position is empty" do
      it "raises an error" do
        expect { board.move_piece([3, 0], [1, 0], :white) }.to raise_error('start position is empty')
      end
    end

    context "when trying to move an opponent's piece" do
      it "raises an error" do
        expect { board.move_piece([6, 0], [5, 0], :black) }.to raise_error('You must move your own piece')
      end
    end

    context "when end position is invalid for the piece" do
      it "raises an error" do
        expect { board.move_piece([6, 0], [3, 0], :white) }.to raise_error('Piece cannot move to end_pos')
      end
    end

    context "when move is valid" do
      it "moves the piece to the desired location" do
        board.move_piece([6, 0], [4, 0], :white)
        expect(board.grid[4][0]).to be_a(Pawn)
        expect(board.grid[6][0]).to be_nil
      end
    end
  end

  describe "#valid_move?" do
    let(:board) { Board.new }
  
    context "when position is within the board" do
      it "returns true" do
        expect(board.valid_move?([4, 4])).to be(true)
        expect(board.valid_move?([0, 0])).to be(true)
        expect(board.valid_move?([7, 7])).to be(true)
      end
    end
  
    context "when position is outside the board" do
      it "returns false" do
        expect(board.valid_move?([-1, 0])).to be(false)
        expect(board.valid_move?([0, -1])).to be(false)
        expect(board.valid_move?([8, 7])).to be(false)
        expect(board.valid_move?([7, 8])).to be(false)
      end
    end
  
    context "when position is not an array or does not have two elements" do
      it "returns false" do
        expect(board.valid_move?(nil)).to be(false)
        expect(board.valid_move?([4])).to be(false)
        expect(board.valid_move?([4, 4, 4])).to be(false)
      end
    end
  end

  describe "#empty?" do
    let(:board) { Board.new }
  
    context "when position is occupied" do
      it "returns false" do
        expect(board.empty?([6, 0])).to be(false)
      end
    end
  
    context "when position is empty" do
      it "returns true" do
        expect(board.empty?([3, 0])).to be(true)
      end
    end
  end

  describe "#enemy?" do
    let(:board) { Board.new }
  
    context "when position is occupied by an enemy piece" do
      it "returns true" do
        expect(board.enemy?([1, 0], :white)).to be(true)
      end
    end
  
    context "when position is occupied by a friendly piece" do
      it "returns false" do
        expect(board.enemy?([6, 0], :white)).to be(false)
      end
    end
  
    context "when position is empty" do
      it "returns false" do
        expect(board.enemy?([3, 0], :white)).to be(false)
      end
    end
  end

  describe "#in_check?" do
    let(:board) { Board.new }
  
    context "when the king is not under attack" do
      it "returns false" do
        expect(board.in_check?(:white)).to be false
      end
    end
  
    context "when the king is under attack" do
      it "returns true" do
        # Moving opponent's piece to a position where it can attack the king
        board.move_piece([6, 5], [5, 5], :white) # move f2 pawn to f3
        board.move_piece([1, 4], [2, 4], :black) # move e7 pawn to e6
        board.move_piece([0, 3], [4, 7], :black) # move black queen to h4
        expect(board.in_check?(:white)).to be true
      end
    end
  end

  describe '#in_checkmate?' do
    # Write your tests here
  end

  # Add more tests for other methods in the Board class
end
