require_relative 'guessing'
class GuessingPlaying
  def initialize
    @game = Guessing.new
    @running = true
  end

  def run
    while @running
      puts 'Bienvenido a Guessing Guru'
      puts '------------------------'
      @game.playing until @game.endgame?
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
      @game = Guessing.new
    end
  end
end

newgame = GuessingPlaying.new
newgame.run
