class Board
  def get_board
    @board
  end

  def update(token, i)
    @board[i] = token
  end

  def available_moves
    @board.filter { |e| e.is_a? Integer }
  end

  def to_paths
    raise("not implemented")
  end

  def score
    raise("not implemented")
  end
end