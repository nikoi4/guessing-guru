require_relative '../lib/human_guessing'

describe HumanGuessing do
  describe '#guessing' do
    it "returns 'error' when guess its not a 4 digit number" do
      newgame = HumanGuessing.new

      actual = newgame.guessing('0234')
      expected = 'Error, favor de adivinar un numero de 4 digitos'

      expect(actual).to eq(expected)
    end

    it "returns '2 good and 2 regular' if there is two exact digit position and 2 other matching digits out of position" do
      newgame = HumanGuessing.new
      newgame.guessme = [1, 2, 4, 3]
      newgame.guessing('1234')

      actual = newgame.clues
      expected = [2, 2]

      expect(actual).to eq(expected)
    end

    it "returns '4 good and 0 regular' if guess matches machine number" do
      newgame = HumanGuessing.new
      newgame.guessme = [1, 2, 3, 4]
      newgame.guessing('1234')

      actual = newgame.clues
      expected = [4, 0]

      expect(actual).to eq(expected)
    end
  end
end
