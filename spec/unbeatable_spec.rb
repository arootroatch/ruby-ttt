require "player/unbeatable"
require 'spec_helper'

describe "unbeatable" do
  before(:each) do
    @player = Unbeatable.new(:o)
    @board = ThreeByThree.new
  end

  it 'should initialize player with token' do
    expect(@player.get_token).to eq(:o)
  end

  it "has a player type of :minimax" do
    expect(@player.type).to eq(:unbeatable)
  end

  it "wins or ties every possible game" do
    expect(unbeatable?(@player, @board)).to eq(true)
  end

end

