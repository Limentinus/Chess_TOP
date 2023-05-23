class Game
  attr_reader :board, :input_output, :current_player

  def initialize(input_output)
    @board = Board.new
    @input_output = input_output
    @current_player = :white
  end

  def play
    until game_over?
      input_output.display_board(@board)
      move = input_output.get_move_input
      make_move(move)
      switch_players
    end
    declare_winner
  end

  private

  def game_over?
    # Return true if the game is over (checkmate or stalemate)
    # This method needs to be defined.
  end

  def prompt_for_move
    # Ask the current player for their move.
    # Return their move.
    # This method needs to be defined.
  end

  def make_move(move)
    # Use the @board object's methods to make the move.
    # This method needs to be defined.
  end

  def switch_players
    @current_player = @current_player == :white ? :black : :white
  end

  def declare_winner
    # Declare the winner of the game.
    # This method needs to be defined.
  end
end

