class HumanView
  def ask(question)
    puts "#{question}"
    puts '>'
    gets.chomp
  end

  def give_clues(good, regular)
    puts "#{good} Bien y #{regular} Regular"
  end
end
