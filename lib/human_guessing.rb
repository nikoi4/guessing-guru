class HumanGuessing
  def initialize
    @digits = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
    @guessme = []
    @guess = []

    guessme_generator
  end

  private

  def guessme_generator
    @guessme << @digits.delete_at(@digits.last(9).sample)
    3.times.each do
      @guessme << @digits.delete_at(rand(@digits.length) - 1)
    end
  end
end
