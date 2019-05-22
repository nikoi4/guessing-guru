require_relative 'machine_view'
require_relative 'machine_guessing'
# muscle
class MachineController
  def initialize(machine_guess)
    @game = machine_guess
    @view = MachineView.new
  end

  def first_and_second_guess
    @game.guessing_generator
    get_input
    @game.take_action
    order_guess if @game.clues.last.sum == 4
  end

  def prepare
    @game.deal_with_digits
  end

  def third_guess_and_more
    until ok
      if @game.three.empty?
        two_two if @game.two.length == 2
        two_six if @game.two.length == 6
        two_eight if @game.two.length == 8
      end
      three_three_or_more unless @game.three.empty?
    end
  end

  def order_guess
    while how_many_good < 4
      zero_good if how_many_good.zero?
      one_good if how_many_good == 1
      two_good if how_many_good == 2
    end
    @view.winner(@game.guess)
  end

  def endgame?
    @game.clues.last[0] == 4
  end

  private

  def get_input
    @game.validate
    @view.tell_guess(@game.guess)
    good = @view.ask_for('How many good')
    regular = @view.ask_for('How many regular')
    until good + regular >= 0 && good + regular < 5
      good = @view.ask_for('How many good')
      regular = @view.ask_for('How many regular')
    end
    @game.clues.push([good, regular])
  end

  def ok
    @game.clues.last.sum == 4
  end

  def three_three_or_more
    @game.three_get_guess
    get_input
    @game.three_take_action
  end

  def two_two
    @game.two_get_guess
    get_input
    @game.two_two_take_action
  end

  def two_six
    @game.two_get_guess
    get_input
    @game.two_six_take_action
  end

  def two_eight
    @game.two_get_guess
    get_input
    @game.two_eight_take_action
  end

  def swap!(number, arguments)
    number[0], number[1], number[2], number [3] = number[arguments[0]], number[arguments[1]], number[arguments[2]], number[arguments[3]]
  end

  def how_many_good
    @game.clues.last[0]
  end

  def zero_good
    c0 = [[1, 0, 3, 2], [1, 2, 3, 0], [2, 3, 0, 1], [2, 0, 3, 1], [3, 2, 1, 0], [3, 0, 1, 2]]
    i = 0
    temp = @game.guess.dup
    while how_many_good.zero?
      @game.clues.last[0] = 2 if i == c0.length
      @game.guess = temp.dup
      swap!(@game.guess, c0[i])
      get_input
      i += 1
    end
  end

  def one_good
    c1 = [[0, 2, 3, 1], [0, 3, 1, 2], [3, 1, 0, 2], [3, 0, 2, 1], [2, 1, 3, 0], [2, 0, 1, 3], [1, 3, 2, 0], [1, 2, 0, 3]]
    i = 0
    temp = @game.guess.dup
    while how_many_good == 1
      @game.clues.last[0] = 2 if i == c1.length
      @game.guess = temp.dup
      swap!(@game.guess, c1[i])
      get_input
      i += 1
    end
  end

  def two_good
    c2 = [[0, 1, 3, 2], [1, 0, 2, 3], [3, 1, 2, 0]]
    i = 0
    temp = @game.guess.dup
    while how_many_good == 2
      @game.clues.last[0] = 0 if i == c2.length
      @game.guess = temp.dup
      swap!(@game.guess, c2[i])
      get_input
      i += 1
    end
  end
end
