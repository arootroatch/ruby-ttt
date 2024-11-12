require_relative 'player'

class Easy < Player

  def initialize(token)
    @token = token
    @type = :easy
  end

  def take_turn(board)
    available = board.available_moves
    move = available[rand(board.available_moves.length)]
    board.update(@token, move)
  end
end