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
    display_game_outcome
  end

  def turn
    position = ''

    until board.valid_move?(position) do
      position = current_player.move
    end

    board.update(position, current_player)
  end

  def current_player
    board.turn_count.even? ? player_1 : player_2
  end

  def winner
    @winner ||= search_winner
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

  private

  def winning_row?(row)
    row.uniq.one? && row.first != Board::EMPTY_CELL
  end

  def search_winner
    WIN_COMBINATIONS.each do |combo|
      row_values = board.cells.values_at(*combo)

      return row_values.first if winning_row?(row_values)
    end

    nil
  end

  def display_game_outcome
    puts won? ? "Congratulations #{winner}!" : "Cat\'s Game!"
  end
end
