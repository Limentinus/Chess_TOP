require_relative '../lib/player'

describe Player do
  let(:player) { Player.new(:white, "Alice") }

  describe '#initialize' do
    it 'initializes with the correct color and name' do
      expect(player.color).to eq(:white)
      expect(player.name).to eq("Alice")
    end
  end
end