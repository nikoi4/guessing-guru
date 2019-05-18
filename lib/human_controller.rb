require_relative 'human_view'
class HumanController
  def initialize(human_guess)
    @game = human_guess
    @view = HumanView.new
  end

  def playing
    guess = @view.ask('Adivina mi numero de 4 digitos')
    until valid?(guess)
      guess = @view.ask('No me engañes! dame un numero de 4 digitos')
    end
    @game.guess_vs_guessme(guess)
    good = @game.good
    regular = @game.regular
    @view.give_clues(good, regular)
  end

  def endgame?
    @game.good == 4
  end

  private

  def valid?(guess)
    guess.to_i.to_s.length == 4 && guess.to_i.integer?
  end
end
