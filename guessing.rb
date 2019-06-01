class Guessing
  def run
    running = true
    while running
      puts 'Bienvenido a Guessing Guru'
      puts '--------------------------'
      playing
      puts 'Ganaste! Queres intentarlo otra vez?(si o no)'
      print '> '
      running = quit(gets.chomp.downcase)
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
      if guessme.include?(digit) && guess.index(digit) == guessme.index(digit)
        good += 1
      elsif guessme.include?(digit)
        regular += 1
      end
    end
    give_clues(good, regular)
  end

  def guessme_generator
    digits = (0..9).to_a.map(&:to_s)
    guessme = digits.sample(4)
    guessme_generator while guessme[0] == '0'
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
    if option == 'si'
      puts `clear`
      true
    else
      puts 'Hasta la proxima!'
      false
    end
  end
end

newgame = Guessing.new
newgame.run
