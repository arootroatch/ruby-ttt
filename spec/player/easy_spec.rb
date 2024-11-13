require "player/easy"
require 'spec_helper'
require 'player/player'

describe Easy do
  before(:each) do
    @player = Easy.new(:o)
    @board = ThreeByThree.new
  end

  it { expect(described_class).to be < Player }

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

  it "does not play unavailable moves" do
    build_x_one_away_board(@board)
    allow(@board).to receive(:available_moves).and_call_original
    allow(@board).to receive(:update).and_call_original
    @player.take_turn(@board)
    expect(@board.get_board).to_not eq([:x, :x, 2, :o, :o, 5, 6, 7, 8])
    expect(@board).to have_received(:available_moves).twice
    expect(@board).to have_received(:update) { |arg1, arg2| [2, 5, 6, 7, 8].include? arg2 }
  end

end

def number_in_coll (coll)
  coll.include?
end