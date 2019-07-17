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

  def won?
    @grid each do |row|
      row.all? { |tile| tile.revealed? && !tile.bombed? }
  end

  def lost?
    @grid each do |row|
      row.any? {|tile| tile.bombed? || tile.revealed? }
    end
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end





end