require_relative 'board'
require 'byebug'

class Minesweeper
  GAME_MODES = {
    'easy' => [9, 10],
    'medium' => [16, 40],
    'hard' => [30, 145],
    'uuddlrlrba' => [9, 1],
  }

  def self.setup
    puts "Welcome to Minesweeper! Please choose from the following:"
    
    mode = get_mode
    debugger
    board = Minesweeper.new(GAME_MODES[mode])

  end
  
  def self.get_mode
    mode = nil
    puts "Type 'easy' for a 9x9 board containing 10 bombs."
    puts "Type 'medium' for a 16x16 board containing 40 bombs."
    puts "Type 'hard for a 30x30 board containing 145 bombs."

      until mode
        mode = gets.chomp 
        unless GAME_MODES.has_key?(mode.downcase)
          puts "Sorry! that is not a valid game mode! Please try again."
          mode = nil  
        end
      end
      mode
  end

  def initialize(game_mode)
    
    size, bombs = game_mode
    @board = Board.new(size, bombs) 
  end

  def run
    until game_over
      board.render
      take_turn
    end
    
    if has_won?
      puts "Congrats, you managed not to blow yourself up."
    elsif has_lost?
      puts "KABOOM! Ya lost a foot... and the game! Game over."
      board.reveal
    end
  end

  def game_over
    if has_won?
      return true
    elsif has.lost?
      return true
    end
    false
  end

  def has_won?
    @board.won?
  end

  def has_lost?
    @board.lost?
  end

  def get_move
    pos = nil
    action = nil

     until pos && valid_pos?(pos)
        puts "Please enter coordinates for a move on the board (ex: 1,3)"
        print '>'
        pos = parse_pos(gets.chomp)
     end
     

    until action && valid_action?(action)
      puts "Please choose your action ('r' to reveal a square, 'f' to flag/unflag a square)"
      puts "Note: you cannot reveal a flagged square until you unflag it."
      print '>'
      action = gets.chomp
    end

    [move, pos]
  end

  def valid_action?(move)
    if action.downcase != 'f' || action.downcase != 'r'
      return false
    end
    action.downcase
  end

  def valid_pos?(pos)
    pos.is_a?(Array) && pos.length == 2 && pos.all? { |v| v.between?(0, board.size - 1) }
  end

  def parse_pos(pos)
    pos.split('').map! { |char| Integer(char) }
  end
  

  def take_turn
    board.render
    action, pos = get_move
    tile = board[pos]

    case action
      when 'f'
        tile.flag_tile
      when 'r'
        tile.reveal
    end
    
  end

  #reveal:
  # Start by supporting a single grid size: 9x9; randomly seed it with bombs. The user has two choices each turn:

  # First, they can choose a square to reveal. If it contains a bomb, game over. Otherwise, it will be revealed. If none of its neighbors contains a bomb, then all the adjacent neighbors are also revealed. If any of the neighbors have no adjacent bombs, they too are revealed. Et cetera.

  # The "fringe" of the revealed area is squares all adjacent to a bomb (or corner). The fringe should be revealed and contain the count of adjacent bombs.

  # The goal of the game is to reveal all the bomb-free squares; at this point the game ends and the player wins.

  # Flag bomb:
  # The user may also flag a square as containing a bomb. A flagged square cannot be revealed unless it is unflagged first. It's possible to flag a square incorrectly, so the behavior should be the same regardless of whether there's a bomb in that square.

  # Flags are there to help the user keep track of bombs and do not factor into the win condition. Once every square that isn't a bomb has been revealed, the player wins regardless of whether they've flagged all the remaining squares.

  # User interaction
  # You decide how to display the current game state to the user. I recommend * for unexplored squares, _ for "interior" squares when exploring, and a one-digit number for "fringe" squares. I'd put an F for flagged spots.

  # You decide how the user inputs their choice. I recommend a coordinate system. Perhaps they should prefix their choice with either "r" for reveal or "f" for flag.
  #ex? [action, [x,y]]



end

if __FILE__ == $PROGRAM_NAME
  game = Minesweeper.setup
  game.run
end