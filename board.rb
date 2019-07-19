require_relative 'tile'


class Board

  attr_reader :size

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
      
      if selected_tile.bombed?
        next
      end

      selected_tile.set_bomb
      set_bombs += 1
    end
  end

  def won?
    @grid.flatten.all? { |tile| tile.revealed? != !tile.bombed? }
    
  end

  def lost?
    @grid.flatten.any? {|tile| tile.bombed? && tile.revealed? }
    
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def reveal
    max = @size - 1
    puts "  #{(0..max).to_a.join(" ")}"
    @grid.each_with_index do |row, idx|
      puts "#{idx} #{row.map(&:reveal).join("  ")}"
    end
  end

  def render
    max = @size - 1
    puts "  #{(0..max).to_a.join(" ")}"
    @grid.each_with_index do |row, idx|
      puts "#{idx} #{row.map(&:render).join(" ")}"
    end
  end





end