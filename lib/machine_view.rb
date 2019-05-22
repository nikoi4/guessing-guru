class MachineView
  def tell_guess(guess)
    puts "I think your number is #{guess.join}"
  end

  def ask_for(question)
    puts question
    print '>'
    gets.chomp.to_i
  end

  def winner(guess)
    puts "I new I was going to get it! #{guess.join}"
  end
end
