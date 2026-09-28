require_relative "question"
require_relative "multiple_choice"
require_relative "numeric_question"
require "sqlite3"

db = SQLite3::Database.open "quiz.db"

class Quiz
  def initialize(questions)
    @questions = questions
    @score = 0
  end

  def run
    system("cls")
    @questions.each do |q|
      reply = q.ask
      unless q.correct?(reply)
        q.hint 
        reply = q.ask
      end
      if q.correct?(reply)
        puts "Rätt!
        "
        @score += 1
      else
        puts "Fel. Rätt svar: #{q.answer}"
      end
    end
    puts "#{@score} av #{@questions.length} rätt."
    @score = 0
  end
end

questions = db.execute( "select * from questions" ).map do |row|
  if row[2] == "mono"
    Question.new(row[0],row[1]) 
  elsif row[2] == "poly"
    MultipleChoice.new(row[0],row[3].split,row[1])
  elsif row[2] == "numeric"
    NumericQuestion.new(row[0],row[1])
  end
end

game = Quiz.new(questions)

loop do
  puts "Starta quiz? (y)"
  game.run if gets.chomp == "y"
  return
end