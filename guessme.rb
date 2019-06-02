# las variables de una clase no son accesibles al menos que se le de acceso explicito
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
    get_input(guess)
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
    guesses = []
    alternatives = guess.permutation(4).to_a.shuffle
    until guessed?
      guesses << current_guess = alternatives.pop
      current_guess = get_input(current_guess)
      alternatives.select! do |possible_guess|
        good = 0
        possible_guess.each_with_index do |pg, index|
          good += 1 if pg == current_guess[index]
        end
        good == @clues.last[0]
      end
    end
  end

  def guessing_generator(digits)
    guess = digits.shuffle!.pop(4)
    guessing_generator while guess[0] == '0'
    guess
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

  def ask_for(question)
    puts question
    print '>'
    answer = gets.chomp
    answer = correct_number_or_try_again(answer)
  end

  def correct_number_or_try_again(answer)
    Integer(answer || '')
  rescue ArgumentError
    ask_for('Are you sure? Try again!')
  end

  def take_action(guess)
    case how_many_guessed
    when 0
      guess.pop(4)
    when 1
      appender(@one, guess, 4)
    when 2
      appender(@two, guess, 4)
    when 3
      appender(@three, guess, 4)
    end
  end

  def deal_with_digits(digits)
    if guessed_in_last_two_clues == 4
      digits.pop(2)
    else
      appender(@two, digits, 2)
    end
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

  def guessed_in_last_two_clues
    @clues[-2].sum + @clues[-1].sum
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
      appender(@three, guess, 4)
      @three.rotate!(-1)
      @two = []
      @one = []
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
    case how_many_guessed
    when 3
      appender(@three, guess, 4)
    when 2
      appender(@two, guess.shuffle!, 4) && @two.rotate!(-1)
    when 1
      appender(@two, guess, 4) && @two.rotate!(-2)
    end
  end

  def two_eight_take_action(guess)
    case how_many_guessed
    when 3
      appender(@three, guess, 4)
    when 2
      appender(@two, guess.rotate!(-1), 4)
    when 1
      appender(@three, @two, 4) && appender(@one, guess, 4)
    when 0
      appender(@three, @two, 4)
    end
  end

  def appender(taker, giver, amount)
    taker.push(giver.pop(amount)).flatten!
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
