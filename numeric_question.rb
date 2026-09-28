require_relative "question"

class NumericQuestion < Question
    attr_reader :prompt, :answer
    def initialize(prompt, answer)
        raise ArgumentError, "prompt must not be empty" if prompt.empty?
        @prompt = prompt
        @answer = answer.to_f
    end

    def correct?(reply)
        reply.gsub(/,/,'.').to_f.round(2) == answer.round(2)
    end
    def hint
        puts "Hint: #{@answer.to_s[0]}"
    end
end