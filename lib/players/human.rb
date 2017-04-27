module Players
  class Human < Player
    def move(board = nil)
      puts 'Pick a square.'
      gets.chomp
    end
  end
end
