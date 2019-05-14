class MachineGuessing
  attr_accessor :three, :two, :one, :digits, :clues, :guess, :out
  def initialize
    @guess = []
    @three = []
    @two = []
    @one = []
    @digits = (0..9).to_a
    @out = []
    @clues = []
  end

  def four
    @three << @three.shift
    @guess = @three.pop(4)
    tell_guess
    ask_for_input
    conditional = analyze(3)
    @three.push(@guess).flatten! if conditional.zero?
  end

  def three_method
    # @three << @one.pop(2) if @three.length == 2
    @three << @two.pop unless @two.empty?
    @three << @one.pop if @two.empty? && !@one.empty?
    @three << @digits.pop if @two.empty? && @one.empty?
    @guess = @three.pop(4)
    tell_guess
    ask_for_input
    conditional = analyze(3)
    case conditional
    when 0 then @three.push(@guess.pop(4)).flatten! && four
    when -1 then @three.push(@guess.pop(4)).flatten!.pop
    end
  end

  def two_method
    @two.push(@two.pop(@two.length).shuffle).flatten! if @two.length > 4
    @two.push(@digits.pop(2)).flatten! if @one.empty? && @two.length == 4
    @two << @one.pop unless @one.empty?
    @guess = @two.pop(4)
    tell_guess
    @clues = ask_for_input
    p @clues
    conditional = analyze(2)
    case conditional
    when 1 then @three.push(@guess.pop(4)).flatten!
    when 0 then @two.push(@guess.pop(4)).flatten!
    when -1 then @one.push(@guess.pop(4)).flatten!
    end
  end

  def guessing_generator(array)
    @guess << array.delete_at(rand(1..(array.length - 1)))
    3.times.each do
      @guess << array.delete_at(rand(array.length) - 1)
    end
    tell_guess
    ask_for_input
    @out.push(@guess.pop(4)).flatten! if @clues.last.sum.zero?
    @one.push(@guess.pop(4)).flatten! if @clues.last.sum == 1
    @two.push(@guess.pop(4)).flatten! if @clues.last.sum == 2
    @three.push(@guess.pop(4)).flatten! if @clues.last.sum == 3
  end

  def ask_for_input
    @clues.push([0, 0])
    # p @clues
    puts 'how many good'
    @clues.last[0] = gets.chomp.to_i
    # p @clues
    puts 'how many regular'
    @clues.last[1] = gets.chomp.to_i
    # p @clues
  end

  def tell_guess
    puts "I think your number is #{@guess.join}"
  end

  def clue_less
    @clues[-2].sum + @clues[-1].sum
  end

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
  newgame.guessing_generator(newgame.digits)
  newgame.two.push(newgame.digits.pop(2)).flatten! if newgame.one.length == 8
  newgame.two.push(newgame.digits.pop(2)).flatten! if newgame.one.length == 4 && newgame.two.length == 4
  # p newgame.out
  # p newgame.one
  # p newgame.two
  # p newgame.three
  # p newgame.clues
  # p newgame.guess
  until newgame.clues.last.sum == 4
    newgame.four if newgame.three.length > 4
    newgame.three_method if newgame.three.length == 4
    newgame.two_method if newgame.two.length >= 4
    newgame.guessing_generator(newgame.one) if newgame.one.length >= 4
    # p newgame.out
    # p newgame.one
    # p newgame.two
    # p newgame.three
    # p newgame.clues
    # p newgame.guess
  end
end

game
