class Board
  attr_accessor :cells

  EMPTY_CELL = ' '
  BOARD_SIZE = 9

  def initialize
    reset!
  end

  def position(index)
    cells[to_valid_index(index)]
  end

  def update(index, player)
    cells[to_valid_index(index)] = player.token
  end

  def full?
    cells.none? { |cell| cell == EMPTY_CELL }
  end

  def taken?(index)
    position(index) != EMPTY_CELL
  end

  def valid_move?(index)
    return false unless (1..BOARD_SIZE).cover? index.to_i

    !taken? index
  end

  def avaliable_moves
    ('1'..'9').select { |index| valid_move? index }
  end

  def turn_count
    cells.size - cells.count(EMPTY_CELL)
  end

  def reset!
    self.cells = Array.new(BOARD_SIZE, EMPTY_CELL)
  end

  def display
    rows = cells.each_slice(3).map { |row| " #{row.join(' | ')} " }
    puts rows.join("\n#{'-' * 11}\n")
  end

  private

  def to_valid_index(index)
    index.to_i - 1
  end
end
