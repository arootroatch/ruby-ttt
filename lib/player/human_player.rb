require_relative '../cli'
require_relative 'player'

class HumanPlayer < Player

  def initialize(token)
    @token = token
    @type = :human
  end

  def take_turn(board)
    CLI.prompt_move(board.board)
    play_valid_move(board)
  end

  private

  def play_valid_move(board)
    input = CLI.get_user_input(0, board.board.length - 1)

    if board.available_moves.include? input
      board.update(@token, input)
      input
    else
      CLI.alert_invalid_move(board)
      play_valid_move(board)
    end
  end
end