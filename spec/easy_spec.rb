require "easy"

describe "easy" do
  before(:each) do
    @player = Easy.new(:o)
    @board = ThreeByThree.new
  end

  it 'should initialize player with token' do
    expect(@player.get_token).to eq(:o)
  end

  it "has a player type of :easy" do
    expect(@player.type).to eq(:easy)
  end

  it "plays any available move at random" do
    allow(@board).to receive(:available_moves).and_call_original
    @player.take_turn(@board)
    expect(@board.get_board).to_not eq([0, 1, 2, 3, 4, 5, 6, 7, 8])
    expect(@board).to have_received(:available_moves).twice
  end

end