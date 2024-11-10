require 'cli'

class HumanPlayer

  def initialize(token)
    @token = token
  end

  def get_token
    @token
  end

  def take_turn(board)
    game_board = board.get_board
    CLI.prompt_move(game_board)
    input = CLI.get_user_input(game_board.length - 1)

    if board.available_moves.include? input
      board.update(@token, input)
    else
      CLI.alert_invalid_move(board)
      input = CLI.get_user_input(game_board.length - 1)
    end
    input
  end
end