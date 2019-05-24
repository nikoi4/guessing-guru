class Guessing
  def initialize
    @digits = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
    @guessme = []
    @guess = 0
    @good = 0
    @regular = 0

    guessme_generator
  end

  def playing
    guess = ask('Adivina mi numero de 4 digitos')
    until valid?(guess)
      guess = ask('No me engañes! dame un numero de 4 digitos')
    end
    guess_vs_guessme(guess)
    give_clues(@good, @regular)
  end

  def endgame?
    @good == 4
  end

  private

  def guess_vs_guessme(guess)
    @good = 0
    @regular = 0
    guess.split('').each do |digit|
      if @guessme.include?(digit.to_i) && guess.index(digit) == @guessme.index(digit.to_i)
        @good += 1
      elsif @guessme.include?(digit.to_i)
        @regular += 1
      end
    end
  end

  def guessme_generator
    @guessme << @digits.delete_at(@digits.last(9).sample)
    3.times.each do
      @guessme << @digits.delete_at(rand(@digits.length) - 1)
    end
  end

  def valid?(guess)
    guess.to_i.to_s.length == 4 && guess.to_i.integer?
  end

  def ask(question)
    puts question
    print '>'
    gets.chomp
  end

  def give_clues(good, regular)
    puts "#{good} Bien y #{regular} Regular"
  end
end
