class FillInBlank
    attr_reader :prompt, :answer
    def initialize(prompt, answer)
        raise ArgumentError, "prompt must not be empty" if prompt.empty?
        @prompt = prompt
        @answer = answer
    end

    def ask
        puts @prompt
        gets.chomp
    end

    def correct?(reply)
        @answer.each{|x|x.tr('-', ' ').downcase == (reply.strip.downcase) ? return true : next}
        return false
    end
end