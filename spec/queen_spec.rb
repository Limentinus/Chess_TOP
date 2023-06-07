require 'rspec'
require_relative '../lib/queen'
require_relative '../lib/piece'
require_relative '../lib/board'

describe Queen do

  describe '#potential_moves' do
    subject(:normal_board) { Board.new }
    context 'When all the spaces around the queen are full' do
      it 'returns empty array' do
        queen = normal_board.piece_at([7, 3])
        expect(queen.potential_moves(normal_board)).to eq([])
      end
    end

    context "when the queen can move" do
      it "returns the correct potential moves" do
        normal_board.move_piece([6, 4], [5, 4], :white) # pawn e2 to e3
        normal_board.move_piece([1, 4], [2, 4], :black) # pawn e7 to e6
        queen = normal_board.piece_at([7, 3])
        expect(queen.potential_moves(normal_board)).to eq([[6, 4], [5, 5], [4, 6], [3, 7]])
      end
    end
  end

  
end
