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

  def get_player_name(color)
    puts "Please enter the name of the #{color} player:"
    gets.chomp
  end

  def display_message(message)
    puts message
  end

  def display_error_message(message)
    puts message.colorize(:red)
  end

  def display_success_message(message)
    puts message.colorize(:green)
  end

  def display_winner_message(color)
    puts "#{color.to_s.capitalize} player wins!"
  end

  def display_draw_message
    puts "The game ends in a draw."
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
