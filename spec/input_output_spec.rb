require 'stringio'
require_relative '../lib/input_output'

describe InputOutput do
  before do
    $stdin = StringIO.new("e4\n") # simulates the user typing "e4" and hitting enter
  end

  after do
    $stdin = STDIN # reset standard input to its original state
  end

  describe '#get_pos' do
    it 'converts user input to board coordinates' do
      input_output = InputOutput.new
      expect(input_output.send(:get_pos)).to eq([4, 4]) # remember get_pos is a private method
    end
  end
end
