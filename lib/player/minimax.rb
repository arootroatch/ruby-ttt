class Minimax

  def initialize(token)
    @token = token
    @opponent_token = @token == :x ? :o : :x
    @minimax ||= {}
  end

  def find_best_move(board)
    best_move = -1
    best_score = -1000
    available_moves = board.available_moves

    available_moves.each do |move|
      board.update(@token, move)
      move_score = @minimax[[board.board, 0, false]] ||= minimax(board, 0, false)
      board.update(move, move) # reset board back to number of index

      if move_score > best_score
        best_move = move
        best_score = move_score
      end
    end
    best_move
  end

  def minimax(board, depth, is_max)
    state = board.score
    token = is_max ? @token : @opponent_token

    if state != :in_progress
      evaluate(state, depth)
    else
      available_moves = board.available_moves
      best = is_max ? -1000 : 1000

      available_moves.each do |move|
        board.update(token, move)
        @minimax[[board.board, depth + 1, !is_max]] ||= minimax(board, depth + 1, !is_max)
        scores = [best, @minimax[[board.board, depth + 1, !is_max]]].minmax
        best = is_max ? scores.last : scores.first
        board.update(move, move)
      end
      best
    end
  end

  def evaluate(state, depth)
    case state
    when :x_wins
      score(@token, :x, depth)
    when :o_wins
      score(@token, :o, depth)
    else
      0
    end
  end

  private

  def score(player_token, winning_token, depth)
    if player_token == winning_token
      10 - depth
    else
      -10 + depth
    end
  end
end