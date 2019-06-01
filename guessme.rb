class Guessme
  def initialize
    @three = []
    @two = []
    @one = []
    @clues = [[0, 0]]
  end

  def run
    running = true
    puts 'Welcome to Guessing Guru'
    puts '------------------------'
    while running
      puts 'Think in a 4 digit number and don\'t tell me I am going to get it!'
      playing
      puts 'I got you! Want to try it again?(yes or no)'
      print '>'
      running = quit(gets.chomp.downcase)
    end
  end

  private

  def playing
    digits = (0..9).to_a
    until guessed?
      2.times do
        guessing_attempt(digits)
        break if guessed?
      end
      break if guessed?

      deal_with_digits(digits)
      guess = third_guess_and_more until how_many_guessed == 4
      order_guess(guess)
    end
  end

  def guessing_attempt(digits)
    guess = guessing_generator(digits)
    take_action(guess)
    order_guess(guess) if how_many_guessed == 4
  end

  def third_guess_and_more
    if @three.empty?
      two_two_or_more
    else
      three_three_or_more
    end
  end

  def order_guess(guess)
    c0 = [[1, 0, 3, 2], [1, 2, 3, 0], [2, 3, 0, 1], [2, 0, 3, 1], [3, 2, 1, 0], [3, 0, 1, 2]]
    c1 = [[0, 2, 3, 1], [0, 3, 1, 2], [3, 1, 0, 2], [3, 0, 2, 1], [2, 1, 3, 0], [2, 0, 1, 3], [1, 3, 2, 0], [1, 2, 0, 3]]
    c2 = [[0, 1, 3, 2], [1, 0, 2, 3], [3, 1, 2, 0], [0, 3, 2, 1], [2, 1, 0, 3]]
    until guessed?
      case how_many_good
      when 0
        guess = ordering(guess, 0, c0)
      when 1
        guess = ordering(guess, 1, c1)
      when 2
        guess = ordering(guess, 2, c2)
      end
    end
    winner(guess)
  end

  def get_input(guess)
    guess = validate(guess)
    tell_guess(guess)
    good = ask_for('How many good')
    regular = ask_for('How many regular')
    @clues.push([good, regular])
    guess
  end

  def validate(guess)
    guess.shuffle! while guess[0].zero?
    guess
  end

  def tell_guess(guess)
    puts "I think your number is #{guess.join}"
  end

  def how_many_good
    @clues.last[0]
  end

  def how_many_guessed
    @clues.last.sum
  end

  def guessed?
    how_many_good == 4
  end

  def three_three_or_more
    if @one.empty? && !@two.empty?
      appender(@three, @two, 1)
    elsif !@one.empty?
      appender(@three, @one, 1)
    end
    guess = @three.pop(4)
    get_input(guess)
    three_take_action(guess)
    guess
  end

  def two_two_or_more
    guess = two_get_guess
    p guess
    case @two.length + guess.length
    when 4
      two_two_take_action(guess)
    when 6
      two_six_take_action(guess)
    when 8
      two_eight_take_action(guess)
    end
    guess
  end

  def three_take_action(guess)
    case how_many_guessed
    when 3
      appender(@three, guess, 4) && @three.rotate!(-1)
    when 2
      appender(@three, guess, 4).pop
    end
  end

  def two_get_guess
    if @two.length == 2
      appender(@two, @one, 2)
    elsif @two.length > 6
      @two.rotate!(-1)
    end
    guess = @two.pop(4)
    get_input(guess)
  end

  def two_two_take_action(guess)
    case how_many_guessed
    when 3
      appender(@three, guess, 4)
    when 2
      appender(@two, guess.first(2), 2)
    end
  end

  def two_six_take_action(guess)
    appender(@three, guess, 4) if how_many_guessed == 3
    appender(@two, guess.shuffle!, 4) && @two.rotate!(-1) if how_many_guessed == 2
    appender(@two, guess, 4) && @two.rotate!(-2) if how_many_guessed == 1
  end

  def two_eight_take_action(guess)
    appender(@three, guess, 4) if how_many_guessed == 3
    appender(@two, guess.rotate!(-1), 4) if how_many_guessed == 2
    appender(@three, @two, 4) && appender(@one, guess, 4) if how_many_guessed == 1
    appender(@three, @two, 4) if how_many_guessed.zero?
    p @three
  end

  def guessing_generator(digits)
    guess = []
    4.times.each do
      guess << digits.delete_at(rand(digits.length) - 1)
    end
    get_input(guess)
  end

  def take_action(guess)
    guess.pop(4) if how_many_guessed.zero?
    appender(@one, guess, 4) if how_many_guessed == 1
    appender(@two, guess, 4) if how_many_guessed == 2
    appender(@three, guess, 4) if how_many_guessed == 3
  end

  def deal_with_digits(digits)
    appender(@two, digits, 2) if guessed_in_last_two_clues < 4
    digits.pop(2) if guessed_in_last_two_clues == 4
  end

  def ordering(guess, good, order)
    i = 0
    temp = guess.dup
    while how_many_good == good
      break if i == order.length

      guess = temp.dup
      swap!(guess, order[i])
      guess = get_input(guess)
      i += 1
    end
    guess
  end


  def guessed_in_last_two_clues
    @clues[-2].sum + @clues[-1].sum
  end

  def swap!(number, order)
    number[0], number[1], number[2], number [3] = number[order[0]], number[order[1]], number[order[2]], number[order[3]]
  end

  def appender(taker, giver, amount)
    taker.push(giver.pop(amount)).flatten!
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
      puts `clear`
      puts 'Hasta la vista baby!'
      false
    elsif option == 'yes'
      puts `clear`
      @clues = [[0, 0]]
      true
    end
  end
end

Guessme.new.run
