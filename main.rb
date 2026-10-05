require_relative "quiz"

game = Quiz.new
game.load_questions

loop do
  puts "Starta quiz? (y)"
  game.run if gets.chomp == "y"
  return
end