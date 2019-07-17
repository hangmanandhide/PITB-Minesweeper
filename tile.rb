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

  def neighbors

  end

  def neighbor_bomb_count
  end
  
  def set_bomb
    @bombed = true
  end
  
  #reveal
  #neighbors
  #neighbor_bomb_count
  #@bombed?
  #@flagged?
  #@revealed?
  #inspect

end