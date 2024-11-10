require "human_player"

describe "human_player" do
  before(:each) do
    @player = HumanPlayer.new(:x)
    @board = ThreeByThree.new
  end
  it 'should initialize player with token' do
    expect(@player.get_token).to eq(:x)
  end

  it "prompts user for move gets user input" do
    allow_any_instance_of(Kernel)
      .to receive(:gets).and_return("1")
    expect { @player.take_turn(@board) }
      .to output("Please enter your move (type a number 0-8 and press 'Enter'):\n").to_stdout_from_any_process
    expect(@player.take_turn(@board)).to eq(1)
  end

  it "only allows entry of available moves" do
    @board.update(:x, 0)
    @board.update(:o, 4)
    allow_any_instance_of(Kernel)
      .to receive(:gets).and_return("0", "4", "5")
    expect { @player.take_turn(@board) }
      .to output("Please enter your move (type a number 0-8 and press 'Enter'):
That square is taken! Please enter an available square [1, 2, 3, 5, 6, 7, 8]:\n")
            .to_stdout_from_any_process
    expect(@player.take_turn(@board)).to eq(5)
  end

  it "updates board" do
    allow_any_instance_of(Kernel)
      .to receive(:gets).and_return("1")
    @player.take_turn(@board)
    expect(@board.get_board).to eq([0, :x, 2, 3, 4, 5, 6, 7, 8])
  end
end