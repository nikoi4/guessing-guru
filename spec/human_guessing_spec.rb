require_relative '../lib/human_guessing'

describe HumanGuessing do
  describe '#guessing' do
    it "returns 'error' when invalid input" do
      newgame = HumanGuessing.new

      actual = newgame.guessing('0234')
      expected = 'Error'

      expect(actual).to eq(expected)
    end

    it "returns '2 good and 2 regular' if there is two exact digit position and 2 other matching digits out of position" do
      newgame = HumanGuessing.new
      newgame.guessme = 1243

      actual = newgame.guessing('1234')
      expected = '2 good and 2 regular'

      expect(actual).to eq(expected)
    end

    it "returns '4 good and 0 regular' if guess matches machine number" do
      newgame = HumanGuessing.new
      newgame.guessme = 1234

      actual = newgame.guessing('1234')
      expected = '4 good and 0 regular'

      expect(actual).to eq(expected)

  end
end
