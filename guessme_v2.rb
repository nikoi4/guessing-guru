# Human think in a number and machine tries to guess it
# Found solution on-line minor modifications by me (running, aget_input, quit)
class GuessmeV2
  def run
    running = true
    puts 'Welcome to Guessing Guru'
    puts '------------------------'
    while running
      puts 'Think in a 4 digit number and don\'t tell me I am going to get it!'
      playing
      puts 'I am that smart! Want to try it again?(yes or no)'
      print '>'
      running = quit(gets.chomp.downcase)
    end
  end

  private

  def playing
    scores = []
    guesses = []
    possible_guesses = [*'0'..'9'].permutation(4).to_a.shuffle

    possible_guesses.reject! do |guess|
      guess[0] == '0'
    end

    loop do
      guesses << current_guess = possible_guesses.pop
      scores << score = get_input(current_guess)

      # handle win
      break if score == [4, 0]

      # filter possible guesses
      possible_guesses.select! do |guess|
        good = guess.zip(current_guess).count { |g, cg| g == cg }
        regular = (guess & current_guess).size - good
        [good, regular] == score
      end

      # handle 'no possible guesses left'
      if possible_guesses.empty?
        puts 'Are you trying to mess around with me?'
        guesses.zip(scores).each { |g, (b, c)| puts "#{g.join} => good #{b} regular #{c}" }
        break
      end
    end
  end

  def get_input(guess)
    tell_guess(guess)
    good = ask_for('How many good')
    regular = ask_for('How many regular')
    [good, regular]
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

  def quit(option)
    if option == 'no'
      puts `clear`
      puts 'See you later alligator!'
      false
    elsif option == 'yes'
      puts `clear`
      true
    end
  end
end

GuessmeV2.new.run
