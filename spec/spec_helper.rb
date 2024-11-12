def build_x_win_board (board)
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