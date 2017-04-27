module Players
  class Computer < Player
    def move(board)
      board.avaliable_moves.sample
    end
  end
end
