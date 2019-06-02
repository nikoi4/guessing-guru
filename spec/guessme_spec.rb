require_relative '../guessme'

describe Guessme do
  describe '#guessing_generator' do
    it "first digit can't be 0" do
      newgame = Guessme.new
      digits = (0..3).to_a

      actual = newgame.guessing_generator(digits)[0]
      expected = 0

      expect(actual).not_to eq(expected)
    end

    it 'does not repeat digits and is a 4 digit number' do
      newgame = Guessme.new
      digits = (0..9).to_a

      actual = newgame.guessing_generator(digits).uniq.size
      expected = 4

      expect(actual).to eq(expected)
    end
  end
end
