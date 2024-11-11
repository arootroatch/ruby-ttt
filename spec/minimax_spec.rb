require "minimax"

describe "minimax" do
  before(:each) do
    @player = Minimax.new(:o)
    @board = ThreeByThree.new
  end

  it 'should initialize player with token' do
    expect(@player.get_token).to eq(:o)
  end

  it "has a player type of :minimax" do
    expect(@player.type).to eq(:minimax)
  end

end