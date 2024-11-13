# frozen_string_literal: true

class Board
  attr_reader :board

  def update(token, idx)
    @board[idx] = token
  end

  def available_moves
    @board.filter { |e| e.is_a? Integer }
  end

  def to_paths
    raise('not implemented')
  end

  def score
    raise('not implemented')
  end
end
