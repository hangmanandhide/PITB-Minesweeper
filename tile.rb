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
    # POS is change in X,Y for all possible 8 moves around a tile.
    #neighbors needs to take change of pos and get adj coords

  end

  def neighbor_bomb_count
    #count # of neighbor tiles w/ bombed?

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
    end

  end

  def reveal
     #do this at the end to show whole board.
     #1. is tile flagged?
     # a - ? for guess flag
     # b - F if bombed is true
     #2. if tile has a bomb
     # a - if revealed, X, else B
      if flagged?
        bombed? ? 'F' : 'f'
      elsif bombed?
        revealed? ? 'X' : 'B'
      else
        "_"
      end
  end
  
  #reveal
  #neighbors
  #neighbor_bomb_count
  #@bombed?
  #@flagged?
  #@revealed?
  #inspect

end