module Players
  class Human < Player
    def move(board)
      puts 'Pick a square.'
      gets.chomp
    end
  end
end
