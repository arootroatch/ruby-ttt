require "cli"

describe CLI do
  it "prints a blank 3x3 board" do
    board = [0, 1, 2, 3, 4, 5, 6, 7, 8]
    expect { CLI.print_board(board) }
      .to output("0 1 2\n3 4 5\n6 7 8\n").to_stdout_from_any_process
  end

  it "prints a 3x3 board with tokens" do
    board = [0, :x, 2, :o, :o, 5, :x, 7, 8]
    expect { CLI.print_board(board) }
      .to output("0 X 2\nO O 5\nX 7 8\n").to_stdout_from_any_process
  end

  it "says whose turn it is" do
    expect { CLI.display_turn(:x) }
      .to output("X's turn!\n").to_stdout_from_any_process
    expect { CLI.display_turn(:o) }
      .to output("O's turn!\n").to_stdout_from_any_process
  end

  it "prompts user to input move" do
    board = [0, 1, 2, 3, 4, 5, 6, 7, 8]
    expect { CLI.prompt_move(board) }
      .to output("Please enter your move (type a number 0-8 and press 'Enter'):\n").to_stdout_from_any_process
    board = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]
    expect { CLI.prompt_move(board) }
      .to output("Please enter your move (type a number 0-15 and press 'Enter'):\n").to_stdout_from_any_process
  end

  it "prompts user for player 1 selection" do
    expect {CLI.prompt_player_selection(1)}
      .to output("Please select an option for Player 1 ('X'):\n1 - Human\n2 - Computer\n").to_stdout_from_any_process
  end

  it "prompts user for player 2 selection" do
    expect {CLI.prompt_player_selection(2)}
      .to output("Please select an option for Player 2 ('O'):\n1 - Human\n2 - Computer\n").to_stdout_from_any_process
  end

  context "get user input" do
    it "only accepts numbers" do
      allow_any_instance_of(Kernel)
        .to receive(:gets).and_return("blah", "1")
      expect {CLI.get_user_input(0, 8)}
        .to output("Oops! Please enter a number from 0 to 8:\n").to_stdout_from_any_process
      expect(CLI.get_user_input(0, 8)).to eq(1)
    end

    it "only accepts numbers up to the given maximum - single digit" do
      allow_any_instance_of(Kernel)
        .to receive(:gets).and_return("9", "5")
      expect {CLI.get_user_input(0, 5)}
        .to output("Oops! Please enter a number from 0 to 5:\n").to_stdout_from_any_process
      expect(CLI.get_user_input(0, 5)).to eq(5)
    end

    it "only accepts numbers up to the given maximum - double digit" do
      allow_any_instance_of(Kernel)
        .to receive(:gets).and_return("17", "0")
      expect {CLI.get_user_input(0, 15)}
        .to output("Oops! Please enter a number from 0 to 15:\n").to_stdout_from_any_process
      expect(CLI.get_user_input(0, 15)).to eq(0)
    end

    it "only accepts numbers above the given minimum" do
      allow_any_instance_of(Kernel)
        .to receive(:gets).and_return("0", "5")
      expect {CLI.get_user_input(1, 5)}
        .to output("Oops! Please enter a number from 1 to 5:\n").to_stdout_from_any_process
      expect(CLI.get_user_input(1, 5)).to eq(5)
    end

    it "accounts for leading 0s" do
      allow_any_instance_of(Kernel)
        .to receive(:gets).and_return("05")
      expect(CLI.get_user_input(0, 8)).to eq(5)
    end
  end

  it "prompts when invalid move and displays valid moves" do
    board = ThreeByThree.new
    board.update(:x, 0)
    board.update(:o, 4)
    expect{CLI.alert_invalid_move(board)}
      .to output("That square is taken! Please enter an available square [1, 2, 3, 5, 6, 7, 8]:\n")
            .to_stdout_from_any_process
    board.update(:x, 2)
    board.update(:o, 7)
    expect{CLI.alert_invalid_move(board)}
      .to output("That square is taken! Please enter an available square [1, 3, 5, 6, 8]:\n")
            .to_stdout_from_any_process
  end

  it "displays the result of the game.rb" do
    expect { CLI.print_result(:x_wins) }
      .to output("X wins!\n").to_stdout_from_any_process
    expect { CLI.print_result(:o_wins) }
      .to output("O wins!\n").to_stdout_from_any_process
    expect { CLI.print_result(:tie) }
      .to output("It's a tie!\n").to_stdout_from_any_process
  end

end