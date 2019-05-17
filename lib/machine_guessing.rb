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

  def three_method
    if @three.length >= 3
      @three << @one.pop if @two.empty? && !@one.empty?
      @three << @two.pop unless @two.empty?
      @guess = @three.pop(4)
      input
      conditional = analyze(3)
      case conditional
      when 0 then apender(@three, @guess, 4)
      when -1 then apender(@three, @guess, 4).pop
      end
    end
    if @two.empty? && @one.empty?
      @guess = @three.push(@three.shift).last(4)
      input
    end
    if @three.length == 2
      apender(@three, @two, 2) if @one.empty?
      apender(@three, @one, 2) if @two.empty?
      @guess = @three.pop(4)
      input
      conditional = analyze(3)
      case conditional
      when 0 then apender(@three, @guess, 4)
      when -1 then apender(@three, @guess, 4).pop
      end
    end
  end

  def two_method
    @two << @two.shift if @two.length > 4
    apender(@two, @one, 2) if @two.length == 2 && !@one.empty?
    @guess = @two.pop(4)
    input
    conditional = analyze(2)
    case conditional
    when 1 then apender(@three, @guess, 4)
    when 0 then apender(@two, @guess, 4)
    when -1 then apender(@one, @guess, 4)
    end
    @guess.pop(4) if @clues.last.sum.zero?
  end

  def guessing_generator(array)
    4.times.each do
      @guess << array.delete_at(rand(array.length) - 1)
    end
  end

  def take_action
    @guess.pop(4) if @clues.last.sum.zero?
    apender(@one, @guess, 4) if @clues.last.sum == 1
    apender(@two, @guess, 4) if @clues.last.sum == 2
    apender(@three, @guess, 4) if @clues.last.sum == 3
    ordering if @clues.last.sum == 4
  end

  def input
    validate(@guess)
    tell_guess
    ask_for_input
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

  private

  def validate(guess)
    argument = [1, 2, 0, 3]
    p guess
    swap!(guess, argument) if guess[0].zero?
  end

  def swap!(number, arguments)
    number[0], number[1], number[2], number [3] = number[arguments[0]], number[arguments[1]], number[arguments[2]], number[arguments[3]]
  end

  def tell_guess
    puts "I think your number is #{@guess.join}"
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

  def analyze(g_plus_r)
    return 4 if @clues.last.sum == 4
    return 1 if @clues.last.sum > g_plus_r && @clues.last.sum < 4
    return 0 if @clues.last.sum == g_plus_r
    return -1 if @clues.last.sum < g_plus_r
  end

  def apender(taker, giver, amount)
    taker.push(giver.pop(amount)).flatten!
  end
end
# if good + regular 4 move to guess delete from others
# if good + regular 3 move to 75 delete from others
# if good + regular 2 move to 50 delete from others
# if good + regular 1 move to 25 delete from others
# if good + regular 0 move to out delete from others

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

game
