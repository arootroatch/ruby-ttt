require_relative "cli"
require_relative "human_player"
require_relative 'three_by_three'
require_relative 'easy'

class TicTacToe

  def initialize(player1 = set_player(1, :x),
                 player2 = set_player(2, :o),
                 board = ThreeByThree.new)
    @player1 = player1
    @player2 = player2
    @board = board
    @turns = 1
  end

  def play_game
    state = @board.score
    player = @turns.even? ? @player2 : @player1
    CLI.print_board(@board.get_board)

    if state == :in_progress
      CLI.display_turn(player.get_token)
      player.take_turn(@board)
      @turns += 1
      play_game
    else
      CLI.print_result(state)
    end
  end

  def get_player(n)
    if n == 1
      [@player1.type, @player1.get_token]
    elsif n == 2
      [@player2.type, @player2.get_token]
    end
  end

  def get_board
    @board.get_board
  end

  def set_player(n, token)
    CLI.prompt_player_selection(n)
    input = CLI.get_user_input(1, 3)
    create_player_instance(input, token)
  end

  def create_player_instance(input, token)
    if input == 1
      HumanPlayer.new(token)
    elsif input == 2
      Easy.new(token)
    elsif input == 3
      Minimax.new(token)
    end
  end
end

if __FILE__ == $0
  TicTacToe.new.play_game
end
