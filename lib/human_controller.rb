class HumanController
  def initialize(human_guess)
    @game = human_guess
    @view = View.new
  end

  def playing
    guess = @view.ask('Adivina mi numero de 4 digitos')
    until valid?(guess)
      guess = @view.ask('No me engañes! dame un numero de 4 digitos')
    end
    @game.guess_vs_guessme
    good = @game.good
    regular = @game.regular
    @view.give_clues(good, regular)
  end

  private

  def valid?(guess)
    # since input is a string I convert it to an integer to avoid 0 as a first digit
    guess.to_i.to_s.length == 4 && guess.to_i.integer?
  end
end
