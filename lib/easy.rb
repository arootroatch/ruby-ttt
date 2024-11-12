class Easy

  def initialize(token)
    @token = token
    @type = :easy
  end

  def get_token
    @token
  end

  def type
    @type
  end

  def take_turn(board)
    board.available_moves
    move = rand(board.available_moves.length)
    board.update(@token, move)
  end
end