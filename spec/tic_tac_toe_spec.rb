require 'tic_tac_toe'

describe "Game of Tic Tac Toe" do

  it "sets user game options to setup game" do
    game = nil
    allow_any_instance_of(Kernel)
      .to receive(:gets).and_return("1", "2")
    expect { game = TicTacToe.new }
      .to output("Please select an option for Player 1 ('X'):\n1 - Human\n2 - Computer
Please select an option for Player 2 ('O'):\n1 - Human\n2 - Computer\n").to_stdout_from_any_process

    expect(game.get_player(1)).to eq([:human, :x])
    expect(game.get_player(2)).to eq([:minimax, :o])
    expect(game.get_board).to eq([0, 1, 2, 3, 4, 5, 6, 7, 8])
  end

  context "play_game" do
    before(:each) do
      @player1 = HumanPlayer.new(:x)
      @player2 = Minimax.new(:o)
      @board = ThreeByThree.new
      @game = TicTacToe.new(@player1, @player2, @board)

      allow($stdout).to receive(:write)
      allow(@player1).to receive(:take_turn)
      allow(@player2).to receive(:take_turn)
    end

    it "prints board at beginning of each turn" do
      build_x_win_board(@board)
      allow(CLI).to receive(:print_board).with(@board.get_board)
      @game.play_game
      expect(CLI).to have_received(:print_board).with(@board.get_board)
    end

    it "checks game state" do
      build_x_win_board(@board)
      allow(@board).to receive(:score)
      @game.play_game
      expect(@board).to have_received(:score)
    end

    it "user takes turn if game in progress" do
      build_x_one_away_board(@board)
      allow(CLI).to receive(:display_turn)
      allow(@player1).to receive(:take_turn) { @board.update(:x, 2) }
      @game.play_game
      expect(CLI).to have_received(:display_turn).with(:x)
      expect(@player1).to have_received(:take_turn)
    end

    it "recurs until game over, toggling player" do
      build_x_one_away_board(@board)
      allow(@player1).to receive(:take_turn) { @board.update(:x, 7) }
      allow(@player2).to receive(:take_turn) { @board.update(:o, 5) }
      @game.play_game
      expect(@game.get_board).to eq([:x, :x, 2, :o, :o, :o, 6, :x, 8])
      expect(@player1).to have_received(:take_turn).once
      expect(@player2).to have_received(:take_turn).once
    end

    it "prints ending game state if game over" do
      allow(CLI).to receive(:print_result)
      build_x_win_board(@board)
      @game.play_game
      expect(CLI).to have_received(:print_result).with(@board.score)
    end
  end
end

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
