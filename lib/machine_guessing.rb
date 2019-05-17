class MachineGuessing
  attr_accessor :three, :two, :one, :digits, :clues, :guess
  def initialize
    @guess = []
    @three = []
    @two = []
    @one = []
    @digits = (0..9).to_a
    @clues = []
    # @winning = []
  end

  # def four
  #   @winning = @three.pop(@three.length) if @winning.empty?
  #   @winning << @winning.shift
  #   @guess = @winning.pop(4)
  #   puts 'four'
  #   p @winning
  #   p @three
  #   p @two
  #   p @one
  #   p @digits
  #   p @guess
  #   input
  #   p @winning
  #   p @three
  #   p @two
  #   p @one
  #   p @digits
  #   p @guess
  #   # conditional = analyze(3)
  #   @winning.push(@guess.pop(4)).flatten!
  #   @guess = @winning
  # end

  def three_method
    if @three.length >= 3
      @three << @one.pop if @two.empty? && !@one.empty?
      @three << @two.pop unless @two.empty?
      @three << @three.shift if @two.empty? && @one.empty?
      @guess = @three.pop(4)
      # puts 'three'
      # p @three
      # p @two
      # p @one
      # p @digits
      # p @guess
      input
      # puts 'three'
      # p @three
      # p @two
      # p @one
      # p @digits
      # p @guess
      conditional = analyze(3)
      case conditional
      when 0 then @three.push(@guess.pop(4)).flatten!
      when -1 then @three.push(@guess.pop(4)).flatten!.pop
      end
    end
    if @three.length == 2
      @three.push(@two.pop(2)).flatten! if @one.empty?
      @three.push(@one.pop(2)).flatten! if @two.empty?
      @guess = @three.pop(4)
      # puts 'three'
      # p @three
      # p @two
      # p @one
      # p @digits
      # p @guess
      input
      # puts 'three'
      # p @three
      # p @two
      # p @one
      # p @digits
      # p @guess
      take_action
    end
  end

  def two_method
    @two << @two.shift if @two.length > 4
    @two << @one.pop if @two.length < 4 && !@one.empty?
    @guess = @two.pop(4)
    # puts 'two'
    # p @three
    # p @two
    # p @one
    # p @digits
    # p @guess
    input
    # puts 'two'
    # p @three
    # p @two
    # p @one
    # p @digits
    # p @guess
    conditional = analyze(2)
    case conditional
    when 1 then @three.push(@guess.pop(4)).flatten!
    when 0 then @two.push(@guess.pop(4)).flatten!
    when -1 then @one.push(@guess.pop(4)).flatten!
    end
    @guess.pop(4) if @clues.last.sum.zero?
  end

  def guessing_generator(array)
    4.times.each do
      @guess << array.delete_at(rand(array.length) - 1)
    end
  end

  def take_action
    # puts 'takeaction'
    # p @three
    # p @two
    # p @one
    # p @digits
    # p @guess
    @guess.pop(4) if @clues.last.sum.zero?
    @one.push(@guess.pop(4)).flatten! if @clues.last.sum == 1
    @two.push(@guess.pop(4)).flatten! if @clues.last.sum == 2
    @three.push(@guess.pop(4)).flatten! if @clues.last.sum == 3
    ordering if @clues.last.sum == 4
    # p @three
    # p @two
    # p @one
    # p @digits
    # p @guess
  end

  def validate(guess)
    argument = [1, 0, 2, 3]
    # p guess
    swap!(guess, argument) if guess[0].zero?
  end

  def swap!(number, arguments)
    number[0], number[1], number[2], number [3] = number[arguments[0]], number[arguments[1]], number[arguments[2]], number[arguments[3]]
  end

  def input
    validate(@guess)
    tell_guess
    ask_for_input
  end

  def ask_for_input
    @clues.push([0, 0])
    # p @clues
    puts 'how many good'
    @clues.last[0] = gets.chomp.to_i
    # p @clues
    puts 'how many regular'
    @clues.last[1] = gets.chomp.to_i
  end

  def tell_guess
    puts "I think your number is #{@guess.join}"
  end

  def ordering
    c0 = [[1, 0, 3, 2], [3, 2, 1, 0], [2, 3, 0, 1]]
    c1 = [[0, 2, 3, 1], [0, 3, 1, 2], [2, 1, 3, 0], [3, 1, 0, 2], [1, 3, 2, 0], [3, 0, 2, 1], [2, 1, 3, 0], [2, 0, 1, 3], [1, 2, 0, 3]]
    c2 = [[0, 1, 3, 2], [1, 0, 2, 3], [3, 1, 2, 0]]
    i = 0
    while @clues.last[0].zero?
      i += 1
      temp = @guess
      swap!(@guess, c0[i])
      input
      @guess = temp
    end
    i = 0
    while @clues.last[0] == 1
      i += 1
      temp = @guess
      swap!(@guess, c1[i])
      input
      @guess = temp
    end
    i = 0
    while @clues.last[0] == 2
      i += 1
      temp = @guess
      swap!(@guess, c2[i])
      input
      @guess = temp
    end
  end

  def clue_less
    @clues[-2].sum + @clues[-1].sum
  end

  # def ordering
  #   @guess.push(@guess.pop(4).shuffle).flatten! && input if @clues.last[0] == 1 || @clues.last[0].zero?
  #   swap!(@guess, 0, 1) && input if @clues.last[0] == 2
  #   swap!(@guess, 0, 1) && swap!(@guess, 2, 3) && input if @clues.last[0].zero?
  #   swap!(@guess, 0, 1) && swap!(@guess, 1, 2) && input if @clues.last[0] == 1
  # end

  private

  def analyze(g_plus_r)
    return 4 if @clues.last.sum == 4
    return 1 if @clues.last.sum > g_plus_r && @clues.last.sum < 4
    return 0 if @clues.last.sum == g_plus_r
    return -1 if @clues.last.sum < g_plus_r
  end
end
# if good + regular 4 move to guess delete from others
# if good + regular 3 move to 75 delete from others
# if good + regular 2 move to 50 delete from others
# if good + regular 1 move to 25 delete from others
# if good + regular 0 move to out delete from others
# 1457
def game
  newgame = MachineGuessing.new
  newgame.guessing_generator(newgame.digits)
  newgame.input
  newgame.take_action
  newgame.guessing_generator(newgame.digits)
  newgame.input
  newgame.take_action
  newgame.three.push(newgame.digits.pop(2)).flatten! if newgame.clue_less == 2
  newgame.two.push(newgame.digits.pop(2)).flatten! if newgame.clue_less == 3
  until newgame.clues.last.sum == 4
    newgame.guessing_generator(newgame.one) && newgame.input && newgame.take_action if newgame.one.length > 4
    newgame.two_method if newgame.two.length >= 2 && newgame.three.length <= 1
    newgame.three_method if newgame.three.length >= 2
    # newgame.four if newgame.three.length > 4 || !newgame.winning.length.zero? && newgame.two.empty?
  end
  newgame.ordering until newgame.clues.last[0] == 4
  puts "See, I told you I was going to get it!! Your number is #{newgame.guess.join}"
end
#9105
game
