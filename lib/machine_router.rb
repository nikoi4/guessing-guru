require_relative 'machine_controller'
require_relative 'machine_guessing'
# app
class MachineRouter
  def initialize
    @controller = MachineController.new(MachineGuessing.new)
    @running = true
  end

  def run
    while @running
      puts 'Welcome to Guessing Guru'
      puts '------------------------'
      puts 'Think in a 4 digit number and don\'t tell me I am going to get it!'
      until @controller.endgame?
        @controller.first_and_second_guess
        break if @controller.endgame?

        @controller.first_and_second_guess
        break if @controller.endgame?

        @controller.prepare
        @controller.third_guess_and_more
        @controller.order_guess
      end
      puts 'I got you! Want to try it again?(yes or no)'
      print '>'
      quit(gets.chomp)
    end
  end

  private

  def quit(option)
    if option.downcase == 'no'
      puts 'See you later!'
      @running = false
    elsif option.downcase == 'yes'
      puts `clear`
      @controller = MachineController.new(MachineGuessing.new)
    end
  end
end

newgame = MachineRouter.new
newgame.run
