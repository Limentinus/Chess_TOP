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
    subject(:empty_board) { Board.new(false) }

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

    context 'when moving a pawn' do
      
      it 'updates the board correctly' do
        # Setup
        initial_position = [6, 0]
        final_position = [4, 0]
        board.move_piece(initial_position, final_position, :white)
  
        # Expectations
        expect(board.piece_at(final_position).class).to eq(Pawn)
        expect(board.piece_at(initial_position)).to be_nil
      end
    end
  
    context 'when moving a queen' do
      it 'updates the board correctly' do
        # Setup
        board.move_piece([6, 4], [5, 4], :white) # pawn e2 to e3
        board.move_piece([1, 4], [2, 4], :black) # pawn e7 to e6
        initial_position = [7, 3]
        final_position = [5, 5]
        board.move_piece(initial_position, final_position, :white) # queen d1 to f3
    
        # Expectations
        expect(board.piece_at(final_position).class).to eq(Queen)
        expect(board.piece_at(initial_position)).to be_nil
      end
    end

    context 'when moving a rook' do
      it 'updates the board correctly' do
        # Setup
        board.move_piece([6, 0], [4, 0], :white) # move a2 pawn to a4
        initial_position = [7, 0]
        final_position = [5, 0]
        board.move_piece(initial_position, final_position, :white)
    
        # Expectations
        expect(board.piece_at(final_position).class).to eq(Rook)
        expect(board.piece_at(initial_position)).to be_nil
      end
    end
    
    context 'when moving a knight' do
      it 'updates the board correctly' do
        # Setup

        initial_position = [7, 1]
        final_position = [5, 2]
        
        board.move_piece(initial_position, final_position, :white)
    
        # Expectations
        expect(board.piece_at(final_position).class).to eq(Knight)
        expect(board.piece_at(initial_position)).to be_nil
      end
    end
    
    context 'when moving a bishop' do
      it 'updates the board correctly' do
        # Setup
        board.move_piece([6, 3], [5, 3], :white) # pawn d2 to d3
        initial_position = [7, 2]
        final_position = [5, 4]
        board.move_piece(initial_position, final_position, :white)
    
        # Expectations
        expect(board.piece_at(final_position).class).to eq(Bishop)
        expect(board.piece_at(initial_position)).to be_nil
      end
    end
    
    context 'when moving a king' do
      it 'updates the board correctly' do
        # Setup
        board.move_piece([6, 4], [5, 4], :white) # pawn e2 to e3
        initial_position = [7, 4]
        final_position = [6, 4]
        board.move_piece(initial_position, final_position, :white)
    
        # Expectations
        expect(board.piece_at(final_position).class).to eq(King)
        expect(board.piece_at(initial_position)).to be_nil
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
    
    context "when the king is not under attack" do
      subject(:check_board) { Board.new }
      it "returns false" do
        expect(check_board.in_check?(:white)).to be false
      end
    end
  
    context "when the king is under attack" do
      subject(:in_check_board) { Board.new(false) }
      it "returns true" do
        fen_string = 'rnb1kbnr/pppp1ppp/4p3/8/7q/2P2P2/PP1PP1PP/RNBQKBNR w KQkq - 0 1'
        in_check_board.setup_from_fen(fen_string)
        expect(in_check_board.in_check?(:white)).to be true
      end
    end
  end

  describe "#in_checkmate?" do
    context "when the king is not in check" do
      it "returns false" do
        board = Board.new
        expect(board.in_checkmate?(:white)).to be false
        expect(board.in_checkmate?(:black)).to be false
      end
    end
  
    context "when the king is in check but can move out of check" do
      it "returns false" do
        check_board = Board.new(Array.new(8) { Array.new(8) })
        
        check_board.grid[0][0] = Rook.new(:black, [0, 0], check_board)
        check_board.grid[1][1] = King.new(:white, [1, 1], check_board)
        check_board.grid[7][7] = King.new(:black, [7, 7], check_board)
        
        expect(check_board.in_checkmate?(:white)).to be false
      end
    end
  
    context "when the king is in checkmate" do
      it "returns true" do
        mate_board = Board.new(false)
        
        fen_string = '8/8/8/8/kQ6/8/8/1R5K b - - 0 1'
        mate_board.setup_from_fen(fen_string)

        expect(mate_board.in_checkmate?(:black)).to be true
      end
    end
  end

  describe '#in_stalemate?' do
    subject(:stalemate_board) { Board.new(false) }
  
    context 'when it is a stalemate' do
      it 'returns true' do
        # Setup a stalemate scenario
        fen_string = '7k/8/8/8/8/6q1/8/7K w - - 0 1'
        stalemate_board.setup_from_fen(fen_string)
        expect(stalemate_board.in_stalemate?(:white)).to be true
      end
    end
  
    context 'when it is not a stalemate' do
      it 'returns false' do
        # Setup a scenario where it's not a stalemate
        # White king on e1, black king on e8, white pawn on e2, black pawn on e7
        fen_string = '4k3/4p3/8/8/8/8/4P3/4K3 w - - 0 1'
        stalemate_board.setup_from_fen(fen_string)
  
        expect(stalemate_board.in_stalemate?(:white)).to be false
      end
    end
  end

  describe "#has_valid_moves?" do
    let(:board) { Board.new }
  
    context "when there are valid moves available for the given color" do
      it "returns true" do
        expect(board.has_valid_moves?(:white)).to be true
      end
    end
  
    context "when there are no valid moves available for the given color" do
      it "returns false" do
        mate_board = Board.new(false)
        
        fen_string = '8/8/8/8/kQ6/8/8/1R5K b - - 0 1'
        mate_board.setup_from_fen(fen_string)
        
        expect(mate_board.has_valid_moves?(:black)).to be false
      end
    end

    context "when the kind is in stalemate" do
      it "returns false" do
        mate_board = Board.new(false)
        
        fen_string = '7k/8/8/8/8/6q1/8/7K w - - 0 1'
        mate_board.setup_from_fen(fen_string)
        
        expect(mate_board.has_valid_moves?(:white)).to be false
      end
    end
  end

  describe "#setup_from_fen" do
    it "correctly sets up the board" do
      fen_string = '8/8/8/8/kQ6/8/8/1R5K b - - 0 1'
      board = Board.new(false)
      board.setup_from_fen(fen_string)

      expect(board.grid[4][0]).to be_a(King)
      expect(board.grid[4][0].color).to eq(:black)
  
      expect(board.grid[4][1]).to be_a(Queen)
      expect(board.grid[4][1].color).to eq(:white)
  
      expect(board.grid[7][1]).to be_a(Rook)
      expect(board.grid[7][1].color).to eq(:white)
  
      expect(board.grid[7][7]).to be_a(King)
      expect(board.grid[7][7].color).to eq(:white)
    end
  end

  describe "#move_into_check?" do
    subject(:simulate_board) { Board.new }
  
    context "when moving a piece puts the king in check" do
      it "returns true" do
        # Setup a scenario where a move would put the king in check
        simulate_board.move_piece([6, 4], [4, 4], :white) 
        simulate_board.move_piece([1, 4], [3, 4], :black) 
        simulate_board.move_piece([6, 0], [4, 0], :white) 
        simulate_board.move_piece([0, 3], [4, 7], :black) 

        expect(simulate_board.move_into_check?([6, 5], [5, 5])).to be true
      end
    end
  
    context "when moving a piece does not put the king in check" do
      it "returns false" do
        # Setup a scenario where a move would not put the king in check
        expect(simulate_board.move_into_check?([6, 3], [5, 3])).to be false
      end
    end
  
    context "when moving a piece captures another piece" do
      it "returns the captured piece to its original position" do
        # Set up a scenario where a piece is captured
        simulate_board.move_piece([6, 4], [4, 4], :white)  # Move white pawn forward
        simulate_board.move_piece([1, 3], [3, 3], :black)  # Move black pawn forward
        simulate_board.move_into_check?([4, 4], [3, 3])       # Capture black pawn
        expect(simulate_board.grid[3][3]).to be_a(Pawn)
        expect(simulate_board.grid[3][3].color).to eq(:black)
      end
    end
  end

  describe '#find_king' do
    context 'when there is only one king on the board' do
      it 'returns the king' do
        # Setup
        board = Board.new(false)
        king_position = [0, 4]
        king = King.new(:white, king_position, board)
        board.grid[0][4] = king
  
        # Action
        found_king = board.send(:find_king, :white)
  
        # Expectations
        expect(found_king).to eq(king)
        expect(found_king.pos).to eq(king_position)
      end
    end
  end
end
