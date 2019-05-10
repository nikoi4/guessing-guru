require_relative '../lib/machine_guessing'

describe HumanGuessing do
  describe '#guessing' do
    it "returns 'error' when guess its not a 4 digit number" do
      newgame = MachineGuessing.new

      actual = newgame.guessing[0]
      expected = '0'

      expect(actual).not_to eq(expected)
    end

    it 'does not repeat digits' do
      newgame = MachineGuessing.new
      guess = newgame.guessing
      check = []

      guess.each do |digit|
        check << digit if guess.count(digit) > 1
      end

      actual = check.empty?
      expected = true

      expect(actual).to eq(expected)
    end

    it "returns '4 good and 0 regular' if guess matches machine number" do
      newgame = MachineGuessing.new

      actual = newgame.guessess.include?(newgame.guessing.split(''))
      expected = false

      expect(actual).to eq(expected)
    end
  end
end

# guess does not start with 0
# guess does not repeat digits
# guess does not repeat itself
