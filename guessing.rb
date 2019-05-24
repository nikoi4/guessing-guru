class Guessing
  def run
    running = true
    while running
      puts 'Bienvenido a Guessing Guru'
      puts '------------------------'
      playing
      puts 'Ganaste! Queres intentarlo otra vez?(si o no)'
      print '> '
      running = quit(gets.chomp)
    end
  end

  private

  def playing
    guessme = guessme_generator
    good = 0
    until good == 4
      guess = ask('Adivina mi numero de 4 digitos')
      if !valid?(guess)
        guess = ask('No me engañes! dame un numero de 4 digitos')
      else
        good = guess_vs_guessme(guess, guessme)
      end
    end
  end

  def guess_vs_guessme(guess, guessme)
    good = 0
    regular = 0
    guess.split('').each do |digit|
      if guessme.include?(digit.to_i) && guess.index(digit) == guessme.index(digit.to_i)
        good += 1
      elsif guessme.include?(digit.to_i)
        regular += 1
      end
    end
    give_clues(good, regular)
  end

  def guessme_generator
    digits = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
    guessme = []
    guessme << digits.delete_at(digits.last(9).sample)
    3.times.each do
      guessme << digits.delete_at(rand(digits.length) - 1)
    end
    guessme
  end

  def valid?(guess)
    guess.to_i.to_s.length == 4 && guess.to_i.integer?
  end

  def ask(question)
    puts question
    print '> '
    gets.chomp
  end

  def give_clues(good, regular)
    puts "#{good} Bien y #{regular} Regular"
    good
  end

  def quit(option)
    if option == 'no'
      puts 'Hasta la proxima!'
      running = false
    elsif option == 'si'
      run
    end
    running
  end
end

newgame = Guessing.new
newgame.run
