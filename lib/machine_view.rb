class MachineView
  def tell_guess(guess)
    puts "I think your number is #{guess.join}"
  end

  def ask_for(question)
    puts question
    puts '>'
    gets.chomp.to_i
  end
end
