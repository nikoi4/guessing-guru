class MachineGuessing
  attr_accessor :three, :two, :one, :digits, :clues, :guess
  def initialize
    @guess = []
    @three = []
    @two = []
    @one = []
    @digits = (0..9).to_a
    @clues = [[0, 0]]
  end

  def three_get_guess
    appender(@three, @two, 1) if @one.empty? && !@two.empty?
    appender(@three, @one, 1) unless @one.empty?
    @guess = @three.pop(4)
  end

  def three_take_action
    appender(@three, @guess, 4) && @three.rotate!(-1) if @clues.last.sum == 3
    appender(@three, @guess, 4).pop if @clues.last.sum == 2
  end

  def two_get_guess
    appender(@two, @one, 2) if !@one.empty? && @two.length == 2
    @two.rotate!(-1) if @two.length == 8
    @guess = @two.pop(4)
  end

  def two_two_take_action
    appender(@three, @guess, 4) if @clues.last.sum == 3
    appender(@two, @guess.first(2), 2) if @clues.last.sum == 2
  end

  def two_six_take_action
    appender(@three, @guess, 4) if @clues.last.sum == 3
    appender(@two, @guess, 4) && @two.rotate!(-1) if @clues.last.sum == 2
    appender(@two, @guess, 4) && @two.rotate!(-2) if @clues.last.sum == 1
  end

  def two_eight_take_action
    appender(@three, @guess, 4) if @clues.last.sum == 3
    appender(@two, @guess.rotate!(-1), 4) if @clues.last.sum == 2
    appender(@three, @two, 4) && appender(@one, @guess, 4) if @clues.last.sum == 1
    appender(@three, @two, 4) if @clues.last.sum.zero?
  end

  def guessing_generator
    4.times.each do
      @guess << @digits.delete_at(rand(@digits.length) - 1)
    end
    @guess
  end

  def take_action
    @guess.pop(4) if @clues.last.sum.zero?
    appender(@one, @guess, 4) if @clues.last.sum == 1
    appender(@two, @guess, 4) if @clues.last.sum == 2
    appender(@three, @guess, 4) if @clues.last.sum == 3
  end

  def deal_with_digits
    @two.push(@digits.pop(2)).flatten! if clue_less == 2
    @two.push(@digits.pop(2)).flatten! if clue_less == 3
  end

  def validate
    argument = [1, 0, 2, 3] if @clues.last.sum < 4
    argument = [1, 2, 3, 0] if @clues.last.sum == 4
    swap!(@guess, argument) if @guess[0].zero?
  end

  private

  def clue_less
    @clues[-2].sum + @clues[-1].sum
  end

  def swap!(number, arguments)
    number[0], number[1], number[2], number [3] = number[arguments[0]], number[arguments[1]], number[arguments[2]], number[arguments[3]]
  end

  def appender(taker, giver, amount)
    taker.push(giver.pop(amount)).flatten!
  end
end
