require_relative '../lib/player'
require_relative '../lib/input_output'

class Game
  def initialize
    @input_output = InputOutput.new
    @board = Board.new
    @players = {
      white: Player.new(:white, @input_output.get_player_name(:white)),
      black: Player.new(:black, @input_output.get_player_name(:black))
    }
    @current_player = @players[:white]
  end

  def play
    until game_over?
      begin
        @input_output.display(@board)
        @input_output.display_message("It's #{@current_player.name}'s turn, playing as #{@current_player.color.to_s.capitalize}.")
        start_pos, end_pos = get_move
        @board.move_piece(start_pos, end_pos, @current_player.color)
      rescue StandardError => e
        @input_output.display_error_message(e.message)
        retry
      end
      switch_players
    end
    end_game
  end

  private

  def get_move
    start_pos = @input_output.get_start_pos
    end_pos = @input_output.get_end_pos
    [start_pos, end_pos]
  end

  def game_over?
    @board.in_checkmate?(@current_player.color) || @board.in_stalemate?(@current_player.color) #|| @board.draw?
  end

  def switch_players
    @current_player = @current_player == @players[:white] ? @players[:black] : @players[:white]
  end

  def end_game
    @input_output.display(@board)
    if @board.in_checkmate?(@current_player.color)
      switch_players
      @input_output.display_winner_message(@current_player.name, @current_player.color)
    else
      @input_output.display_draw_message
    end
  end
  
  
end

