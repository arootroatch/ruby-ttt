require_relative 'board'

class ThreeByThree < Board

  def initialize
    @board = [0, 1, 2, 3, 4, 5, 6, 7, 8]
  end

  def to_paths
    paths = []
    to_horizontals(paths)
    to_verticals(paths)
    to_diagonals(paths)
  end

  def score
    paths = to_paths
    if x_wins?(paths)
      :x_wins
    elsif o_wins?(paths)
      :o_wins
    elsif available_moves.empty?
      :tie
    else
      :in_progress
    end
  end

  private

  def to_horizontals (paths)
    paths << @board.take(3)
    paths << @board.drop(3).take(3)
    paths << @board.drop(6).take(3)
  end

  def to_verticals (paths)
    paths << [@board[0], @board[3], @board [6]]
    paths << [@board[1], @board[4], @board [7]]
    paths << [@board[2], @board[5], @board [8]]
  end

  def to_diagonals (paths)
    paths << [@board[0], @board[4], @board [8]]
    paths << [@board[2], @board[4], @board [6]]
  end

  def x_wins? (paths)
    filtered = paths.filter { |path| path == [:x, :x, :x] }
    !filtered.empty?
  end

  def o_wins? (paths)
    filtered = paths.filter { |path| path == [:o, :o, :o] }
    !filtered.empty?
  end
end
