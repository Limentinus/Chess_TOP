class Game
  def initialize(input_output)
    @input_output = input_output
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
    # Placeholder - you'll need to implement this method
    false
  end

  def switch_players
    @current_player = @current_player == @players[:white] ? @players[:black] : @players[:white]
  end

  def end_game
    # Placeholder - you'll need to implement this method
  end
end


