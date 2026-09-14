class Question
  attr_reader :prompt, :answer
  def initialize(prompt, answer)
    raise ArgumentError, "prompt must not be empty" if prompt.empty?
    @prompt = prompt
    @answer = answer.to_s
  end

  def ask
    puts prompt
    gets.chomp
  end

  def correct?(reply)
    reply.strip.downcase == answer.downcase
  end

  def to_s
    "#{prompt}"
  end
  
  def hint
    puts "Hint: #{@answer[0]}"
  end
end
