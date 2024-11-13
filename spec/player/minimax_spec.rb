require 'player/minimax'
require 'spec_helper'

describe "minimax" do
  before(:each) do
    @board = ThreeByThree.new
    @minimax = Minimax.new(:o)
  end

  it "wins or ties every possible game" do
    expect(unbeatable?(@minimax, @board)).to eq(true)
  end

  context "find best move" do
    it "returns best move - full board" do
      allow(@minimax).to receive(:minimax).and_return(10, 0, 2, 1, 5, 6, 7, 8, 4)
      expect(@minimax.find_best_move(@board)).to eq(0)
    end

    it "returns best move - half full board" do
      board = ThreeByThree.new
      build_x_one_away_board(board)
      allow(@minimax).to receive(:minimax).and_return(10, 0, 2, 1, 5)
      expect(@minimax.find_best_move(board)).to eq(2)
    end
  end

  context "evaluate" do
    [[Minimax.new(:o), :o_wins, :x_wins, :tie, "O"],
     [Minimax.new(:x), :x_wins, :o_wins, :tie, "X"]].map { |options|
      context "player #{options.last}" do
        it "returns 10 if player wins with depth 0" do
          expect(options[0].evaluate(options[1], 0)).to eq(10)
        end

        it "returns 5 if player is :o and wins with depth 5" do
          expect(options[0].evaluate(options[1], 5)).to eq(5)
        end

        it "returns -10 if player loses with depth 0" do
          expect(options[0].evaluate(options[2], 0)).to eq(-10)
        end

        it "returns -5 if player loses with depth 5" do
          expect(options[0].evaluate(options[2], 5)).to eq(-5)
        end

        it "returns zero if tie regardless of depth" do
          expect(options[0].evaluate(options[3], 9)).to eq(0)
        end
      end
    }

  end
end