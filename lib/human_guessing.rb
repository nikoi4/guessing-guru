class HumanGuessing
  attr_accessor :clues
  def initialize
    @digits = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
    @guessme = []
    @guess = 0
    @clues = [0, 0]

    guessme_generator
  end

  def guessing(guess)
    if valid?(guess)
      # verify if number matches then chek for index
      guess.split('').each do |digit|
        if @guessme.include?(digit.to_i) && guess.index(digit) == @guessme.index(digit.to_i)
          @clues[0] += 1
        elsif @guessme.include?(digit.to_i)
          @clues[1] += 1
        end
      end
    else
      puts 'Error, favor de adivinar un numero de 4 digitos'
    end
  end

  private

  def valid?(guess)
    # since input is a string I convert it to an integer to avoid 0 as a first digit
    guess.to_i.to_s.length == 4
  end

  def guessme_generator
    @guessme << @digits.delete_at(@digits.last(9).sample)
    3.times.each do
      @guessme << @digits.delete_at(rand(@digits.length) - 1)
    end
  end
end

# interface
newgame = HumanGuessing.new
until newgame.clues[0] == 4
  newgame.clues = [0, 0]
  puts 'Adivina un numero de 4 digitos'
  newgame.guessing(gets.chomp)
  puts "#{newgame.clues[0]} Bien y #{newgame.clues[1]} Regular"
end
puts 'ganaste!!'
