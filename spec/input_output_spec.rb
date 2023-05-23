require_relative '../lib/input_output'

describe InputOutput do
  let(:input_output) { InputOutput.new }

  describe '#get_player_name' do
    before do
      allow(input_output).to receive(:gets).and_return("Alice\n")
    end

    it 'prompts for and returns the player name' do
      expect(input_output.get_player_name(:white)).to eq("Alice")
    end
  end

  describe '#display_message' do
    it 'displays the message' do
      expect { input_output.display_message("Hello!") }.to output("Hello!\n").to_stdout
    end
  end

  describe '#display_error_message' do
    it 'displays the error message in red' do
      expect { input_output.display_error_message("Error!") }.to output("\e[0;31;49mError!\e[0m\n").to_stdout
    end
  end

  describe '#display_success_message' do
    it 'displays the success message in green' do
      expect { input_output.display_success_message("Success!") }.to output("\e[0;32;49mSuccess!\e[0m\n").to_stdout
    end
  end

  describe '#display_winner_message' do
    it 'displays the winner message' do
      expect { input_output.display_winner_message(:white) }.to output("White player wins!\n").to_stdout
    end
  end

  describe '#display_draw_message' do
    it 'displays the draw message' do
      expect { input_output.display_draw_message }.to output("The game ends in a draw.\n").to_stdout
    end
  end

  describe 'private #get_pos' do
    before do
      allow(input_output).to receive(:gets).and_return("e4\n")
    end

    it 'converts user input to board coordinates' do
      expect(input_output.send(:get_pos)).to eq([4, 4])
    end
  end
end