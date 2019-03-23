require_relative 'Board'

class Game

  def initialize
    @board = Board.new
    play
  end

  def validate_pos(pos)
    pos[0] >= 0 && pos[0] <= 8 && pos[1] >= 0 && pos[1] <= 8
  end

  def prompt_pos
    loop do
      puts "Enter coordinates on board to change in format of x y, x,y or x, y"
      pos = gets.chomp.split(%r{,|\s}).map {|e| e.to_i}
      return pos if validate_pos(pos)
      puts "Invalid input, try again"
    end
  end

  def validate_val(val)
    val >= 1 && val <= 9
  end

  def prompt_val
    loop do
      puts "Enter value between 1 and 9 for the tile"
      val = gets.chomp.to_i
      return val if validate_val(val)
      puts "Invalid input, try again"
    end
  end

  def play
    until @board.solved?
      puts
      print "The board is still not solved!".colorize(:blue)
      @board.render
      @board[prompt_pos] = prompt_val
    end
  end

end

Game.new