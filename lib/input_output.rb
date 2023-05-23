require 'colorize'
require_relative 'board'
require_relative 'piece'


class InputOutput
  

  def display(board)
    puts "  a b c d e f g h".colorize(:blue)
    board.grid.each_with_index do |row, idx|
      print "#{8 - idx} ".colorize(:blue)
      row.each_with_index do |piece, col_idx|
        background = (idx + col_idx).odd? ? :light_black : :light_white
        symbol = piece.nil? ? "  ".colorize(background: background) : "#{piece.symbol} ".colorize(color: piece.color == :white ? :white : :black, background: background)
        print symbol
      end
      puts "#{8 - idx}".colorize(:blue)
    end
    puts "  a b c d e f g h".colorize(:blue)
  end

  def get_start_pos
    puts "Enter the position of the piece you want to move (e.g., 'e2'):"
    get_pos
  end

  def get_end_pos
    puts "Enter the position where you want to move the piece (e.g., 'e4'):"
    get_pos
  end

  private

  def get_pos
    pos = gets.chomp
    # convert from chess notation to board array indices
    [8 - pos[1].to_i, pos[0].downcase.ord - 'a'.ord]
  end
  
end

# input_output = InputOutput.new
# board = Board.new
# input_output.display(board)
