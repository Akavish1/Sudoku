require_relative  'Tile'

class Board

  attr_accessor :grid

  #a static factory method for creating grids from text files
  def self.from_file
    grid = Array.new(9){[]}
    File.open(self.file_input).each.with_index do |line, i| 
      line.each_char {|c| grid[i] << Tile.new(c)}
    end
    grid
  end

  #verifies that file exists, and returns file input if so
  def self.file_input
    loop do
      #puts "Enter file name"
      input = File.join(__dir__, "../puzzles/" + "sudoku1" + ".txt")
      return input if File.file?(input)
      puts "File not found, try again"
    end
  end

  def initialize
    @grid = Board.from_file
  end

  def print_first_line
    print "\n  "
    (0..8).each {|n| print n}
    print "\n  " 
    (0..8).each {print "-"}
    puts
  end

  def render
    print_first_line
    @grid.each.each_with_index do |arr, i|
      print "#{i}|"
      arr.each {|tile| tile.to_s}
    end
    puts "\n\n"
  end


  def check_counter(hash)
    hash.each {|k, v| return false if (v != 1 && k.to_i != 0)}
    true
  end

  def satisfying_rows?
    @grid.all? do |arr|
      hash = Hash.new(0)
      arr.each {|e| hash[e.value] += 1}
      check_counter(hash)
    end
  end

  def satisfying_columns?
    (@grid.length).times do |i1|
      hash = Hash.new(0)
      @grid.each.with_index do |row, i2|
        hash[(row[i1].value)] += 1
      end
      return false if !check_counter(hash)
    end
    true
  end


  def check_squares(rows)
    hash1 = Hash.new(0)
    hash2 = Hash.new(0)
    hash3 = Hash.new(0)
    rows.each do |row|
      row[0..2].each {|e| hash1[e.value] += 1}
      row[3..5].each {|e| hash2[e.value] += 1}
      row[6..8].each {|e| hash3[e.value] += 1}
    end
    check_counter(hash1) && check_counter(hash2) && check_counter(hash3)
  end


  def satisfying_squares?
    check_squares(@grid[0..2]) && check_squares(@grid[3..5]) && check_squares(@grid[6..8])
  end

  def no_zeroes?
    @grid.all? {|arr| arr.all? {|e| e.value.to_i != 0}}
  end

  def solved?
    satisfying_rows? && satisfying_columns? && satisfying_squares? && no_zeroes?
  end


  def [](pos)
    @grid[pos[0]][pos[1]]
  end

  def []=(pos, value)
    @grid[pos[0]][pos[1]] = Tile.new(value)
  end


end


