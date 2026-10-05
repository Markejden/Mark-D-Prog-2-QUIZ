require_relative "questions/question"
require_relative "questions/multiple_choice"
require_relative "questions/numeric_question"
require_relative "questions/self_graded"
require_relative "questions/fillinblank"
require "sqlite3"

class Quiz
  def initialize
    @db = SQLite3::Database.open "quiz.db"
    @questions = []
    @score = 0
  end

  def run
    system("cls")
    @questions.each do |q|
      reply = q.ask
      unless q.correct?(reply) || (q.respond_to?(:hint) == false)
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

  def load_questions
    @questions = @db.execute( "select * from questions" ).map do |col|
      if col[2] == "mono"
        Question.new(col[0],col[1]) 
      elsif col[2] == "poly"
        MultipleChoice.new(col[0],col[3].split,col[1])
      elsif col[2] == "numeric"
        NumericQuestion.new(col[0],col[1])
      elsif col[2] == "selfg"
        SelfGraded.new(col[0],col[1])
      elsif col[2] == "fillin"
        FillInBlank.new(col[0],col[1].split)
      end
    end
  end
end
