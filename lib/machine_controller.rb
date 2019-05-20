require_relative 'machine_view'
require_relative 'machine_guessing'
class MachineController
  def initialize
    @game = MachineGuessing.new
    @view = MachineView.new
  end

  def first_and_second_guess
    @game.guessing_generator
    get_input
    @game.take_action
  end

  def prepare
    @game.deal_with_digits
    # p @game.one
    # p @game.two
    # p @game.three
    # p @game.digits
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

  def ordering
  end

  private

  def get_input
    @game.validate
    @view.tell_guess(@game.guess)
    good = @view.ask_for('How many good')
    regular = @view.ask_for('How many regular')
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
end

controller = MachineController.new
controller.first_and_second_guess
controller.first_and_second_guess
controller.prepare
controller.third_guess_and_more
