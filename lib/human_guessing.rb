class HumanGuessing
  def initialize
    @digits = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
    @guessme = []
    @guess = []

    guessme_generator
  end

  private

  def guessme_generator
    4.times.each do
      @guessme << @digits.delete_at(rand(@digits.length))
    end
  end
end
