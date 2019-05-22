require_relative '../lib/machine_guessing'

describe MachineGuessing do
  describe '#guessing' do
    it "first digit can't be 0" do
      newgame = MachineGuessing.new
      newgame.guessing_generator

      actual = newgame.guess[0]
      expected = '0'

      expect(actual).not_to eq(expected)
    end

    it 'does not repeat digits' do
      newgame = MachineGuessing.new
      newgame.guessing_generator
      guess = newgame.guess
      check = []

      guess.each do |digit|
        check << digit if guess.count(digit) > 1
      end

      actual = check.empty?
      expected = true

      expect(actual).to eq(expected)
    end

    it 'guess is a 4 digit number' do
      newgame = MachineGuessing.new
      newgame.guessing_generator

      actual = newgame.guess.length
      expected = 4

      expect(actual).to eq(expected)
    end
  end
end
