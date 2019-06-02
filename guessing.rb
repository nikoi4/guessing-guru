# Human try to guess number by machine
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

  # private

  def playing
    guessme = guessme_generator
    loop do
      guess = ask('Adivina mi numero de 4 digitos')
      guess = ask('No me engañes! dame un numero de 4 digitos') until valid?(guess)
      good = guess_vs_guessme(guess, guessme)
      break if good == 4
    end
  end

  def guess_vs_guessme(guess, guessme)
    new_guess = guess.split('')
    good = 0
    guessme.each_with_index do |gd, index|
      good += 1 if gd == new_guess[index]
    end
    regular = (new_guess & guessme).size - good
    give_clues(good, regular)
    good
  end

  def guessme_generator
    digits = (0..9).to_a.map(&:to_s)
    guessme = digits.sample(4)
    if guessme[0] == '0'
      guessme = guessme_generator
    end
    guessme
  end

  def valid?(guess)
    guess.to_i.digits.count == 4 && guess.to_i.integer?
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

# newgame = Guessing.new.run
