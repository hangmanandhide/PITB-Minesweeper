require_relative 'board'
require 'byebug'
require 'yaml'

class Minesweeper
  GAME_MODES = {
    'easy' => [9, 10],
    'medium' => [16, 40],
    'hard' => [30, 145],
    'uuddlrlrba' => [9, 1],
  }

  def self.setup
    system("clear")
    puts "Welcome to Minesweeper! Please choose from the following:"
    
    mode = get_mode
    # debugger
    case mode
      when 'load'
        load_saved_game
        else
          board = Minesweeper.new(GAME_MODES[mode])
    end

  end

  def self.load_saved_game
    puts "Please specify the filename of the saved game you would like to use:"
    print ">"
    filename = gets.chomp
    loaded_game = YAML.load(File.read("#{filename}.yml"))
  end
  
  def self.get_mode
    mode = nil
    puts "Type 'easy' for a 9x9 board containing 10 bombs."
    puts "Type 'medium' for a 16x16 board containing 40 bombs."
    puts "Type 'hard' for a 30x30 board containing 145 bombs."
    puts "Type 'load' to load a previously saved game."

      until mode
        mode = gets.chomp 
        unless GAME_MODES.has_key?(mode.downcase) || mode.downcase == 'load'
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



  def save_game
    puts "What would you like to name your saved game?"
    print ">"
    filename = gets.chomp
    File.open("#{filename}.yml", "w") { |file| file.write(self.to_yaml) }
    true
  end

  def run
    take_turn until game_over
    
    if has_won?
      system("clear")
      @board.reveal
      puts "Congrats, you managed not to blow yourself up."
    elsif has_lost?
      system("clear")
      @board.reveal
      puts "KABOOM! Ya lost a foot... and the game! Game over."
    end
  end

  def game_over
    if has_won? || has_lost?
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
      puts "You may also save your game by typing 's'"
      puts "Note: you cannot reveal a flagged square until you unflag it."
      print '>'
      action = gets.chomp
    end

    [action, pos]
  end

  def valid_action?(action)
      if action.downcase == 'f'
        true
      elsif action.downcase == 'r'
        true
      elsif action.downcase == 's'
        true
      else
        false
    end
  end

  def valid_pos?(pos)
    pos.is_a?(Array) && pos.length == 2 && pos.all? { |v| v.between?(0, @board.size - 1) }
  end

  def parse_pos(pos)
    return false if !pos.include?(',')
    pos.split(',').map! { |char| Integer(char) }
  end
  

  def take_turn
    system("clear")
    @board.render
    action, pos = get_move
    
    tile = @board[pos]

    case action
      when 'f'
        tile.flag_tile
      when 'r'
        tile.show
      when 's'
        save_game
        if save_game
          system("clear")
          puts "Game has been saved. You may exit terminal now."
        end
    end
    
  end


end

if __FILE__ == $PROGRAM_NAME
  game = Minesweeper.setup
  game.run
end