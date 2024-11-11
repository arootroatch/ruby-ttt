require 'game'

describe "Game of Tic Tac Toe" do
  before(:all) do
    @game = nil
  end

  it "sets user game options to setup game" do
    allow_any_instance_of(Kernel)
      .to receive(:gets).and_return("1", "2")
    expect { @game = Game.new }
      .to output("Please select an option for Player 1 ('X'):\n1 - Human\n2 - Computer
Please select an option for Player 2 ('O'):\n1 - Human\n2 - Computer\n").to_stdout_from_any_process

    expect(@game.get_player(1)).to eq([:human, :x])
    expect(@game.get_player(2)).to eq([:minimax, :o])
  end


end