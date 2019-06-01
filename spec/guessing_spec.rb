require_relative '../guessing'

describe Guessing do
  describe '#guessme' do
    it 'guessme is an integer' do
      actual = Guessing.new.guessme_generator.join.to_i.integer?
      expected = true

      expect(actual).to eq(expected)
    end

    it 'guessme 4 digits' do
      actual = Guessing.new.guessme_generator.length
      expected = 4

      expect(actual).to eq(expected)
    end
  end

  describe '#guess_vs_guessme' do
    it "returns '2 good if 2 maching numbers and position" do
      newgame = Guessing.new

      actual = newgame.guess_vs_guessme('1243', %w(1 2 3 4))
      expected = 2

      expect(actual).to eq(expected)
    end

    it "returns '4 good and 0 regular' if guess matches machine number" do
      newgame = Guessing.new

      actual = newgame.guess_vs_guessme('1234', %w(1 2 3 4))
      expected = 4

      expect(actual).to eq(expected)
    end
  end
end
