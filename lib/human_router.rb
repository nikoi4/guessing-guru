require_relative 'human_controller'
require_relative 'human_guessing'
# app
class HumanRouter
  def initialize
    @controller = HumanController.new(HumanGuessing.new)
    @running = true
  end

  def run
    while @running
      puts 'Bienvenido a Guessing Guru'
      puts '------------------------'
      @controller.playing until @controller.endgame?
      puts 'Ganaste! Queres intentarlo otra vez?(si o no)'
      puts '>'
      quit(gets.chomp)
    end
  end

  private

  def quit(option)
    if option == 'no'
      puts 'Hasta la proxima!'
      @running = false
    elsif option == 'si'
      @controller = HumanController.new(HumanGuessing.new)
    end
  end
end

newgame = HumanRouter.new
newgame.run
