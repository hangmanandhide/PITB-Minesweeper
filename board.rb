require_relative 'tile'


class Board

  def initialize(size, bombs)
    @size = size
    @bombs = bombs

    generate_board
    set_bombs
  end

  def generate_board
    @grid = Array.new(@size) do |row|
      Array.new(@size) { |col| Tile.new(self, [row, col]) }
      end
  end

  def set_bombs
    set_bombs = 0
    until set_bombs == @bombs
      pos = Array.new(2) { rand(@size) }
      selected_tile = self[pos]

      selected_tile.set_bomb
      set_bombs += 1
    end
  end



  def [](pos)
    row, col = pos
    @grid[row][col]
  end





end