class MachineGuessing
  attr_accessor :three, :two, :one, :digits, :clues, :guess
  def initialize
    @guess = []
    @three = []
    @two = []
    @one = []
    @digits = (0..9).to_a
    @clues = []
  end

  def three_get_guess
    # if @one.empty? && @two.empty?
    appender(@three, @one, 1) unless @one.empty?
    appender(@three, @two, 1) if @one.empty? && !@two.empty?
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
    p @one
    p @two
    p @three
    p @guess
  end

  def two_eight_take_action
    appender(@three, @guess, 4) if @clues.last.sum == 3
    appender(@two, @guess.rotate!(-1), 4) if @clues.last.sum == 2
    appender(@three, @two, 4) if @clues.last.sum == 1 || @clues.last.sum.zero?
  end

  # def three_method
  #   if @three.length >= 3 && (!@two.empty? || !@one.empty?)
  #     @three << @one.pop if @two.empty? && !@one.empty?
  #     @three << @two.pop unless @two.empty?
  #     @guess = @three.pop(4)
  #     input
  #     conditional = analyze(3)
  #     case conditional
  #     when 0 then appender(@three, @guess, 4)
  #     when -1 then appender(@three, @guess, 4).pop
  #     end
  #   end
  #   if @two.empty? && @one.empty?
  #     if @clues.last.sum == 3
  #       @guess = @three.rotate!(-1).last(4)
  #     end
  #     if @clues.last.sum == 2
  #       @guess = @three.rotate!(-2).last(4)
  #     end
  #     input
  #   end
  #   if @three.length == 2
  #     appender(@three, @two, 2) unless @two.empty?
  #     appender(@three, @one, 2) if @two.empty?
  #     @guess = @three.pop(4)
  #     input
  #     conditional = analyze(3)
  #     case conditional
  #     when 0 then appender(@three, @guess, 4)
  #     when -1 then appender(@three, @guess, 4).pop
  #     end
  #   end
  # end

  # def two_method
  #   @two.push(@two.shift(3).shuffle).flatten! if @two.length > 4
  #   appender(@two, @one, 2) if @two.length == 2 && !@one.empty?
  #   @guess = @two.pop(4)
  #   input
  #   conditional = analyze(2)
  #   case conditional
  #   when 1 then appender(@three, @guess, 4)
  #   when 0 then appender(@two, @guess, 4)
  #   when -1 then appender(@one, @guess, 4)
  #   end
  #   @guess.pop(4) if @clues.last.sum.zero?
  # end

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
    ordering if @clues.last.sum == 4
  end

  def deal_with_digits
    @two.push(@digits.pop(2)).flatten! if clue_less == 2
    @two.push(@digits.pop(2)).flatten! if clue_less == 3
  end

  def ordering
    c0 = [[1, 0, 3, 2], [3, 2, 1, 0], [2, 3, 0, 1]]
    c1 = [[0, 2, 3, 1], [0, 3, 1, 2], [2, 1, 3, 0], [3, 1, 0, 2], [1, 3, 2, 0], [3, 0, 2, 1], [2, 1, 3, 0], [2, 0, 1, 3], [1, 2, 0, 3]]
    c2 = [[0, 1, 3, 2], [1, 0, 2, 3], [3, 1, 2, 0]]
    i = 0
    while @clues.last[0].zero?
      temp = @guess
      swap!(@guess, c0[i])
      input
      @guess = temp
      i += 1
      @clues.last[0] = 2 if i == c0.length
    end
    i = 0
    while @clues.last[0] == 1
      temp = @guess
      swap!(@guess, c1[i])
      input
      @guess = temp
      i += 1
    end
    i = 0
    while @clues.last[0] == 2
      temp = @guess
      swap!(@guess, c2[i])
      input
      @guess = temp
      i += 1
    end
  end

  def validate
    argument = [1, 0, 2, 3]
    swap!(@guess, argument) if @guess[0].zero?
  end

  private

  def clue_less
    @clues[-2].sum + @clues[-1].sum
  end

  def swap!(number, arguments)
    number[0], number[1], number[2], number [3] = number[arguments[0]], number[arguments[1]], number[arguments[2]], number[arguments[3]]
  end

  # def ask_for_input
  #   @clues.push([0, 0])
  #   # p @clues
  #   puts 'how many good'
  #   @clues.last[0] = gets.chomp.to_i
  #   # p @clues
  #   puts 'how many regular'
  #   @clues.last[1] = gets.chomp.to_i
  # end

  # def analyze(g_plus_r)
  #   return 4 if @clues.last.sum == 4
  #   return 1 if @clues.last.sum > g_plus_r && @clues.last.sum < 4
  #   return 0 if @clues.last.sum == g_plus_r
  #   return -1 if @clues.last.sum < g_plus_r
  # end

  def appender(taker, giver, amount)
    taker.push(giver.pop(amount)).flatten!
  end
end
# if good + regular 4 move to guess delete from others
# if good + regular 3 move to 75 delete from others
# if good + regular 2 move to 50 delete from others
# if good + regular 1 move to 25 delete from others
# if good + regular 0 move to out delete from others

# def game
#   newgame = MachineGuessing.new
#   newgame.guessing_generator(newgame.digits)
#   newgame.input
#   newgame.take_action
#   newgame.guessing_generator(newgame.digits)
#   newgame.input
#   newgame.take_action

#   until newgame.clues.last.sum == 4
#     newgame.guessing_generator(newgame.one) && newgame.input && newgame.take_action if newgame.one.length > 4
#     newgame.two_method if newgame.two.length >= 2 && newgame.three.length <= 1
#     newgame.three_method if newgame.three.length >= 2
#     # newgame.four if newgame.three.length > 4 || !newgame.winning.length.zero? && newgame.two.empty?
#   end
#   newgame.ordering until newgame.clues.last[0] == 4
#   puts "See, I told you I was going to get it!! Your number is #{newgame.guess.join}"
# end
# game
