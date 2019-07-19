class Tile
  POS = [
    [-1,1],
    [0,1],
    [1,1],
    [-1,0],
    [1,0],
    [-1,-1],
    [0,-1],
    [1,-1]
  ]

  def initialize(board, pos)
    @board = board
    @pos = pos
    @bombed = false
    @flagged = false
    @revealed = false
  end

  def bombed?
    @bombed
  end

  def flagged?
    @flagged
  end

  def revealed?
    @revealed
  end

  def flag_tile
    @flagged = !@flagged unless @revealed
  end

  def neighbors
    row, col = @pos
    neighbors_pos = POS.map do |dX, dY|
      [row + dX, col + dY]
    end

    valid_neighbors_pos = neighbors_pos.select do |coords|
      coords.all? { |v| v.between?(0, @board.size - 1) }
    end

    adj_neighbors = valid_neighbors_pos.map { |neighbor_pos| @board[neighbor_pos] }

  end

  def neighbor_bomb_count
    #count # of neighbor tiles w/ bombed?
    neighbors.select(&:bombed?).count
  end
  
  def set_bomb
    @bombed = true
  end

  def render
    #render needs to be either '?' for a flagged tile
    #revealed? either "_" or count of adj bombs as string/to_s
    
    if flagged?
      '?'
    elsif revealed?
      neighbor_bomb_count == 0 ? "_" : neighbor_bomb_count.to_s
    else
      "*"
    end

  end

  def show
    #need a method to SHOW a tile (reveal a tile, not reveal whole board)
    #needs to change revealed state to true
    #needs to check to see if bomb is false and if any neighbors have a bomb
    # --if both are true, show each neighbor.?
    return self if revealed?

    @revealed = true
    if !bombed? && neighbor_bomb_count == 0
      neighbors.each(&:show)
    end
    self
  end

  def reveal
     #do this at the end to show whole board.
     #1. is tile flagged?
     # a - ? for guess flag
     # b - F if bombed is true
     #2. if tile has a bomb
     # a - if revealed, X, else B
      if flagged?
        bombed? ? "F" : "/"
      elsif bombed?
        revealed? ? "X" : "B"
      else
        "_"
      end
  end
  
  def inspect
    {
      'pos' => @pos,
      'flagged' => @flagged,
      'bombed' => @bombed,
      'revealed' => @revealed
    }.inspect
  end

  #reveal
  #neighbors
  #neighbor_bomb_count
  #@bombed?
  #@flagged?
  #@revealed?
  #inspect

end