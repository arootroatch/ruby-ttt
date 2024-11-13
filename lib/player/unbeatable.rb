require_relative 'player'
require_relative 'minimax'

class Unbeatable < Player

  def initialize(token)
    @token = token
    @type = :unbeatable
    @minimax = Minimax.new(@token)
  end

  def take_turn(board, minimax = @minimax)
    move = minimax.find_best_move(board)
    board.update(@token, move)
  end
end