# frozen_string_literal: true

require 'player/unbeatable'
require 'player/minimax'
require 'player/player'

describe Unbeatable do
  before(:each) do
    @minimax = Minimax.new(:o)
    @player = Unbeatable.new(:o)
    @board = ThreeByThree.new
  end

  it { expect(described_class).to be < Player }

  it 'should initialize player with token' do
    expect(@player.token).to eq(:o)
  end

  it 'has a player type of :minimax' do
    expect(@player.type).to eq(:unbeatable)
  end

  it 'uses minimax and plays move to board' do
    allow(@minimax).to receive(:find_best_move).and_return(0)
    @player.take_turn(@board, @minimax)
    expect(@board.board).to eq([:o, 1, 2, 3, 4, 5, 6, 7, 8])
    expect(@minimax).to have_received(:find_best_move)
  end
end
