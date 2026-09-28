require_relative "question"

class MultipleChoice < Question
    attr_reader :alternatives
    def initialize(prompt, alternatives, answer)
        super(prompt,answer)
        raise ArgumentError, "answer must be one of the alternatives" unless alternatives.include?(answer)
        @alternatives = alternatives
    end

    def ask
        puts prompt
        p alternatives
        gets.chomp
    end

    def correct?(reply)
        alternatives[(reply.to_i-1)].downcase == answer.downcase
    end
end