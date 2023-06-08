require_relative '../lib/game'
require_relative '../lib/input_output'

describe Game do
  let(:input_output) { InputOutput.new }
  let(:game) { Game.new(input_output) }

  before do
    allow(input_output).to receive(:get_player_name).with(:white).and_return("Alice")
    allow(input_output).to receive(:get_player_name).with(:black).and_return("Bob")
  end

  describe '#initialize' do
    it 'initializes the game with the correct components' do
      expect(game.instance_variable_get(:@board)).to be_an_instance_of(Board)
      expect(game.instance_variable_get(:@players)[:white]).to be_an_instance_of(Player)
      expect(game.instance_variable_get(:@players)[:black]).to be_an_instance_of(Player)
      expect(game.instance_variable_get(:@players)[:white].name).to eq("Alice")
      expect(game.instance_variable_get(:@players)[:black].name).to eq("Bob")
      expect(game.instance_variable_get(:@current_player)).to eq(game.instance_variable_get(:@players)[:white])
    end
  end

  describe '#get_move' do
    it 'returns the correct start and end positions' do
      allow(input_output).to receive(:get_start_pos).and_return([1, 2])
      allow(input_output).to receive(:get_end_pos).and_return([3, 4])
      expect(game.send(:get_move)).to eq([[1, 2], [3, 4]])
    end
  end

  describe '#game_over?' do
    it 'returns true if the current player is in checkmate' do
      allow(game.instance_variable_get(:@board)).to receive(:in_checkmate?).with(:white).and_return(true)
      expect(game.send(:game_over?)).to be true
    end

    it 'returns false if the current player is not in checkmate' do
      allow(game.instance_variable_get(:@board)).to receive(:in_checkmate?).with(:white).and_return(false)
      expect(game.send(:game_over?)).to be false
    end
  end

  describe '#end_game' do
    it 'displays a winner message if there is a winner' do
      allow(input_output).to receive(:display)
      allow(game.instance_variable_get(:@board)).to receive(:in_checkmate?).with(:white).and_return(true)
      allow(input_output).to receive(:display_winner_message)
      expect(input_output).to receive(:display_winner_message).with(:black)
      game.send(:end_game)
    end

    it 'displays a draw message if the game ends in a draw' do
      allow(input_output).to receive(:display)
      allow(game.instance_variable_get(:@board)).to receive(:in_checkmate?).with(:white).and_return(false)
      allow(input_output).to receive(:display_draw_message)
      expect(input_output).to receive(:display_draw_message)
      game.send(:end_game)
    end
  end
end