class SelfGraded
    attr_reader :prompt, :answer
    def initialize(prompt, answer)
        raise ArgumentError, "prompt must not be empty" if prompt.empty?
        @prompt = prompt
        @answer = answer
    end

    def ask
        puts prompt
        gets
        puts answer
        puts "hade du rätt? (j/n)"
        gets.chomp
    end

    def correct?(reply)
        reply.upcase == "J" ? true : false
    end
end