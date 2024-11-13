require "player/human_player"
require "player/player"

describe HumanPlayer do
  before(:each) do
    @player = HumanPlayer.new(:x)
    @board = ThreeByThree.new
  end

  it { expect(described_class).to be < Player }

  it 'should initialize player with token' do
    expect(@player.get_token).to eq(:x)
  end

  it "has player type :human" do
    expect(@player.type).to eq(:human)
  end

  context "take_turn" do

    it "prompts user for move and gets user input" do
      allow_any_instance_of(Kernel)
        .to receive(:gets).and_return("1")
      expect { @player.take_turn(@board) }
        .to output("Please enter your move (type a number 0-8 and press 'Enter'):\n").to_stdout_from_any_process
    end

    it "only allows entry of available moves" do
      @board.update(:x, 0)
      @board.update(:o, 4)
      allow_any_instance_of(Kernel)
        .to receive(:gets).and_return("0", "4", "5")
      expect { @player.take_turn(@board) }
        .to output("Please enter your move (type a number 0-8 and press 'Enter'):
That square is taken! Please enter an available square [1, 2, 3, 5, 6, 7, 8]:
That square is taken! Please enter an available square [1, 2, 3, 5, 6, 7, 8]:\n")
              .to_stdout_from_any_process
    end

    it "updates board" do
      allow($stdout).to receive(:write)
      allow_any_instance_of(Kernel)
        .to receive(:gets).and_return("1")
      @player.take_turn(@board)
      expect(@board.get_board).to eq([0, :x, 2, 3, 4, 5, 6, 7, 8])
    end
  end
end