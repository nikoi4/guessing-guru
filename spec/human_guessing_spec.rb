require_relative '../lib/human_guessing'

describe HumanGuessing do
  describe '#guessme' do
    it 'guessme is an integer' do
      actual = HumanGuessing.new.guessme.join.to_i.integer?
      expected = true

      expect(actual).to eq(expected)
    end

    it 'guessme 4 digits' do
      actual = HumanGuessing.new.guessme.length
      expected = 4

      expect(actual).to eq(expected)
    end
  end

  describe '#guess_vs_guessme' do
    it "returns '2 good and 2 regular' if 2 maching numer and position and 2 only number" do
      newgame = HumanGuessing.new
      newgame.guessme = [1, 2, 4, 3]
      newgame.guess_vs_guessme('1234')

      actual = [newgame.good, newgame.regular]
      expected = [2, 2]

      expect(actual).to eq(expected)
    end

    it "returns '4 good and 0 regular' if guess matches machine number" do
      newgame = HumanGuessing.new
      newgame.guessme = [1, 2, 3, 4]
      newgame.guess_vs_guessme('1234')

      actual = [newgame.good, newgame.regular]
      expected = [4, 0]

      expect(actual).to eq(expected)
    end
  end
end
