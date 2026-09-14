require_relative "question"
require "sqlite3"

db = SQLite3::Database.open "quiz.db"

class Quiz
  def initialize(questions)
    @questions = questions
    @score = 0
  end

  def run
    @questions.each do |q|
      reply = q.ask
      unless q.correct?(reply)
        q.hint 
        reply = q.ask
      end
      if q.correct?(reply)
        puts "Rätt!"
        @score += 1
      else
        puts "Fel. Rätt svar: #{q.answer}"
      end
    end
    puts "#{@score} av #{@questions.length} rätt."
    @score = 0
  end
end

questions = db.execute( "select * from questions" ).map {|row| Question.new(row[0],row[1])}

game = Quiz.new(questions)

loop do
  puts "Starta spel? (y)"
  game.run if gets.chomp == "y"
  return
end