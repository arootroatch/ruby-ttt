require "cli"
require "human_player"

class Game

  def initialize
    @player1 = set_player(1, :x)
    @player2 = set_player(2, :o)
  end

  def get_player(n)
    if n == 1
      [@player1.type, @player1.get_token]
    elsif n == 2
      [@player2.type, @player2.get_token]
    end
  end

  private
  def set_player(n, token)
    CLI.prompt_player_selection(n)
    input = CLI.get_user_input(1, 2)
    input == 1 ? HumanPlayer.new(token) : Minimax.new(token)
  end

end