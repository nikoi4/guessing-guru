class Guessme
  def initialize
    # @guess = []
    @three = []
    @two = []
    @one = []
    @digits = (0..9).to_a
    @clues = [[0, 0]]
  end

  def run
    running = true
    while running
      puts 'Welcome to Guessing Guru'
      puts '------------------------'
      puts 'Think in a 4 digit number and don\'t tell me I am going to get it!'
      playing
      puts 'I got you! Want to try it again?(yes or no)'
      print '>'
      running = quit(gets.chomp.downcase)
    end
  end

  private

  def playing
    until endgame?
      first_and_second_guess
      break if endgame?

      first_and_second_guess
      break if endgame?

      deal_with_digits
      guess = third_guess_and_more
      p guess
      order_guess(guess)
    end
  end

  def first_and_second_guess
    guess = guessing_generator
    take_action(guess)
    order_guess(guess) if @clues.last.sum == 4
  end

  def third_guess_and_more
    until ok
      if @three.empty?
        guess = two_two if @two.length == 2
        guess = two_six if @two.length == 6
        guess = two_eight if @two.length == 8
      end
      guess = three_three_or_more unless @three.empty?
    end
    guess
  end

  def order_guess(guess)
    while how_many_good < 4
      guess = zero_good(guess) if how_many_good.zero?
      guess = one_good(guess) if how_many_good == 1
      guess = two_good(guess) if how_many_good == 2
    end
    winner(guess)
  end

  def endgame?
    @clues.last[0] == 4
  end

  def get_input(guess)
    guess = validate(guess)
    tell_guess(guess)
    good = ask_for('How many good')
    regular = ask_for('How many regular')
    until good + regular >= 0 && good + regular < 5
      good = ask_for('How many good')
      regular = ask_for('How many regular')
    end
    @clues.push([good, regular])
    guess
  end

  def ok
    @clues.last.sum == 4
  end

  def three_three_or_more
    guess = three_get_guess
    three_take_action(guess)
    guess
  end

  def two_two
    guess = two_get_guess
    two_two_take_action(guess)
    guess
  end

  def two_six
    guess = two_get_guess
    two_six_take_action(guess)
    guess
  end

  def two_eight
    guess = two_get_guess
    two_eight_take_action(guess)
    guess
  end

  def how_many_good
    @clues.last[0]
  end

  def zero_good(guess)
    c0 = [[1, 0, 3, 2], [1, 2, 3, 0], [2, 3, 0, 1], [2, 0, 3, 1], [3, 2, 1, 0], [3, 0, 1, 2]]
    i = 0
    temp = guess.dup
    while how_many_good.zero?
      @clues.last[0] = 2 if i == c0.length
      guess = temp.dup
      swap!(guess, c0[i])
      guess = get_input(guess)
      i += 1
    end
    guess
  end

  def one_good(guess)
    c1 = [[0, 2, 3, 1], [0, 3, 1, 2], [3, 1, 0, 2], [3, 0, 2, 1], [2, 1, 3, 0], [2, 0, 1, 3], [1, 3, 2, 0], [1, 2, 0, 3]]
    i = 0
    temp = guess.dup
    while how_many_good == 1
      @clues.last[0] = 2 if i == c1.length
      guess = temp.dup
      swap!(guess, c1[i])
      guess = get_input(guess)
      i += 1
    end
    guess
  end

  def two_good(guess)
    c2 = [[0, 1, 3, 2], [1, 0, 2, 3], [3, 1, 2, 0]]
    i = 0
    temp = guess.dup
    while how_many_good == 2
      @clues.last[0] = 0 if i == c2.length
      guess = temp.dup
      swap!(guess, c2[i])
      guess = get_input(guess)
      i += 1
    end
    guess
  end

  def three_get_guess
    appender(@three, @two, 1) if @one.empty? && !@two.empty?
    appender(@three, @one, 1) unless @one.empty?
    guess = @three.pop(4)
    get_input(guess)
  end

  def three_take_action(guess)
    appender(@three, guess, 4) && @three.rotate!(-1) if @clues.last.sum == 3
    appender(@three, guess, 4).pop if @clues.last.sum == 2
  end

  def two_get_guess
    appender(@two, @one, 2) if !@one.empty? && @two.length == 2
    @two.rotate!(-1) if @two.length > 4
    guess = @two.pop(4)
    get_input(guess)
  end

  def two_two_take_action(guess)
    appender(@three, guess, 4) if @clues.last.sum == 3
    appender(@two, guess.first(2), 2) if @clues.last.sum == 2
  end

  def two_six_take_action(guess)
    appender(@three, guess, 4) if @clues.last.sum == 3
    appender(@two, guess.rotate!(-1), 4) if @clues.last.sum == 2
    appender(@two, guess, 4) && @two.rotate!(-2) if @clues.last.sum == 1
  end

  def two_eight_take_action(guess)
    appender(@three, guess, 4) if @clues.last.sum == 3
    appender(@two, guess.rotate!(-1), 4) if @clues.last.sum == 2
    appender(@three, @two, 4) && appender(@one, guess, 4) if @clues.last.sum == 1
    appender(@three, @two, 4) if @clues.last.sum.zero?
  end

  def guessing_generator
    guess = []
    4.times.each do
      guess << @digits.delete_at(rand(@digits.length) - 1)
    end
    get_input(guess)
  end

  def take_action(guess)
    guess.pop(4) if @clues.last.sum.zero?
    appender(@one, guess, 4) if @clues.last.sum == 1
    appender(@two, guess, 4) if @clues.last.sum == 2
    appender(@three, guess, 4) if @clues.last.sum == 3
  end

  def deal_with_digits
    @two.push(@digits.pop(2)).flatten! if clue_less == 2
    @two.push(@digits.pop(2)).flatten! if clue_less == 3
  end

  def validate(guess)
    argument = [1, 0, 2, 3] if @clues.last.sum < 4
    argument = [1, 2, 3, 0] if @clues.last.sum == 4
    swap!(guess, argument) if guess[0].zero?
    guess
  end

  def clue_less
    @clues[-2].sum + @clues[-1].sum
  end

  def swap!(number, arguments)
    number[0], number[1], number[2], number [3] = number[arguments[0]], number[arguments[1]], number[arguments[2]], number[arguments[3]]
  end

  def appender(taker, giver, amount)
    taker.push(giver.pop(amount)).flatten!
  end

  def tell_guess(guess)
    puts "I think your number is #{guess.join}"
  end

  def ask_for(question)
    puts question
    print '>'
    gets.chomp.to_i
  end

  def winner(guess)
    puts "I new I was going to get it! #{guess.join}"
  end

  def quit(option)
    if option == 'no'
      puts 'Hasta la vista baby!'
      running = false
    elsif option == 'yes'
      Guessme.new.run
      running = false
    end
    running
  end
end

newgame = Guessme.new
newgame.run
