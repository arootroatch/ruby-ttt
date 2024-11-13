# frozen_string_literal: true

def build_x_win_board(board)
  board.update(:x, 0)
  board.update(:o, 3)
  board.update(:x, 1)
  board.update(:o, 4)
  board.update(:x, 2)
end

# X plays 2 for an X win
# X plays 7 and O plays 5 for O win
def build_x_one_away_board(board)
  board.update(:x, 0)
  board.update(:o, 3)
  board.update(:x, 1)
  board.update(:o, 4)
end

def unbeatable?(minimax, board)
  all_possible_combos = board.board.permutation.map { |arr| arr.take(5) }
  no_dupes = all_possible_combos.to_set
  has_lost = false
  game_count = 0

  no_dupes.each do |combo|
    reset_board(board)
    game_count += 1
    result = play_sim_game(combo, minimax, board)
    if result == :x_wins
      has_lost = true
      break
    end
  end
  puts "-----------Minimax tested against #{game_count} games-----------"
  !has_lost
end

def play_sim_game(combo, minimax, board)
  is_ai = false
  state = board.score

  combo.each do |move|
    state = board.score
    game_board = board.board

    if state != :in_progress || !move
      break
    elsif game_board[move].is_a? Symbol
      state = :o_wins
      break
    elsif is_ai
      ai_move = minimax.find_best_move(board)
      board.update(:o, ai_move)
    else
      board.update(:x, move)
    end

    is_ai = !is_ai
  end
  state
end

def reset_board(board)
  (0..8).each do |n|
    board.update(n, n)
  end
end
