class Game
  attr_accessor :board, :player_1, :player_2

  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [6,4,2]
  ]

  def initialize(player_1 = Players::Human.new('X'), player_2 = Players::Human.new('O'), board = Board.new)
    @player_1 = player_1
    @player_2 = player_2
    @board = board
  end

  def play
    turn until over?

    puts won? ? "Congratulations #{winner}!" : "Cat\'s Game!"
  end

  def turn
    loop do
      position = current_player.move
      if board.valid_move?(position)
        board.update(position, current_player)
        break
      end
    end
  end

  def current_player
    board.turn_count.even? ? player_1 : player_2
  end

  def winner
    WIN_COMBINATIONS.each do |combo|
      row_values = board.cells.values_at(*combo)

      return row_values.first if winning_row?(row_values)
    end

    nil
  end

  def over?
    draw? || won?
  end

  def won?
    !!winner
  end

  def draw?
    board.full? && !won?
  end

  def winning_row?(row)
    row.uniq.one? && row.first != Board::EMPTY_CELL
  end
end
