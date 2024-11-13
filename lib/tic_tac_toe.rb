require_relative 'cli'
require_relative 'board_factory'
require_relative 'player_factory'

class TicTacToe

  def initialize(player1 = PlayerFactory.set_player(1, :x),
                 player2 = PlayerFactory.set_player(2, :o),
                 board = BoardFactory.create_board_instance)
    @player1 = player1
    @player2 = player2
    @board = board
    @turns = 1
  end

  def play_game
    state = @board.score
    player = @turns.even? ? @player2 : @player1
    CLI.print_board(@board.board)

    if state == :in_progress
      CLI.display_turn(player.token)
      player.take_turn(@board)
      @turns += 1
      play_game
    else
      CLI.print_result(state)
    end
  end

  def get_player(n)
    if n == 1
      [@player1.type, @player1.token]
    elsif n == 2
      [@player2.type, @player2.token]
    end
  end

  def board
    @board.board
  end
end

if __FILE__ == $0
  TicTacToe.new.play_game
end
