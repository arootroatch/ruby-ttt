# frozen_string_literal: true

require 'player/minimax'
require 'spec_helper'

describe 'minimax' do
  before(:each) do
    @board = ThreeByThree.new
    @minimax = Minimax.new(:o)
  end

  it 'block opponent whenever possible' do
    [[0, 6, 1, 2], [4, 1, 5, 3], [6, 5, 7, 8], [0, 4, 3, 6],
     [1, 0, 4, 7], [2, 4, 5, 8], [0, 3, 4, 8], [2, 3, 4, 6]].map do |arr|
      @board.update(:x, arr[0])
      @board.update(:o, arr[1])
      @board.update(:x, arr[2])
      expect(@minimax.find_best_move(@board)).to eq(arr[3])
      reset_board(@board)
    end
  end

  it 'wins whenever possible instead of blocking' do
    @minimax = Minimax.new(:x)
    [[0, 2, 3, 5, 6], [2, 0, 5, 3, 8], [1, 0, 4, 3, 7], [0, 3, 1, 4, 2],
     [3, 0, 4, 1, 5], [6, 3, 7, 4, 8], [0, 2, 4, 6, 8], [2, 0, 4, 8, 6]].map do |arr|
      @board.update(:x, arr[0])
      @board.update(:o, arr[1])
      @board.update(:x, arr[2])
      @board.update(:o, arr[3])
      expect(@minimax.find_best_move(@board)).to eq(arr[4])
      reset_board(@board)
    end
  end

  it 'plays center if first move is a corner' do
    [0, 2, 6, 8].map do |move|
      @board.update(:x, move)
      expect(@minimax.find_best_move(@board)).to eq(4)
      reset_board(@board)
    end
  end

  it 'finds best move if can not win or block' do
    build_no_wins_or_blocks_board(@board)
    expect(@minimax.find_best_move(@board)).to eq(4)
  end

  it 'wins or ties every possible game' do
    expect(unbeatable?(@minimax, @board)).to eq(true)
  end

  context 'find best move' do
    it 'returns best move - full board' do
      allow(@minimax).to receive(:minimax).and_return(10, 0, 2, 1, 5, 6, 7, 8, 4)
      expect(@minimax.find_best_move(@board)).to eq(0)
    end

    it 'returns best move - half full board' do
      board = ThreeByThree.new
      build_x_one_away_board(board)
      allow(@minimax).to receive(:minimax).and_return(10, 0, 2, 1, 5)
      expect(@minimax.find_best_move(board)).to eq(2)
    end
  end

  context 'minimax' do
    before(:each) do
      build_two_moves_left_board(@board)
    end
    it 'plays each possible move, toggling players, and scores the given board state' do
      allow(@minimax).to receive(:minimax).and_call_original
      # is_max starts as false because the maximizer's turn is the board that's input to the function
      expect(@minimax.minimax(@board, 6, false)).to eq(-3)
      expect(@minimax).to have_received(:minimax).with(@board, 6, false)
      expect(@minimax).to have_received(:minimax).twice.with(@board, 7, true)
      expect(@minimax).to have_received(:minimax).with(@board, 8, false)
    end

    it 'sets board back to original state' do
      @minimax.minimax(@board, 6, false)
      expect(@board.board).to eq([:x, 1, :o, :o, :o, :x, :x, 7, :x])
    end

    it 'plays each possible move, toggling players, and scores the given board state - plays as X' do
      @board.update(:o, 1)
      allow(@minimax).to receive(:minimax).and_call_original
      expect(@minimax.minimax(@board, 6, true)).to eq(3)
      expect(@minimax).to have_received(:minimax).with(@board, 6, true)
      expect(@minimax).to have_received(:minimax).with(@board, 7, false)
    end
  end

  context 'evaluate' do
    [[Minimax.new(:o), :o_wins, :x_wins, :tie, 'O'],
     [Minimax.new(:x), :x_wins, :o_wins, :tie, 'X']].map do |options|
      context "player #{options.last}" do
        it 'returns 10 if player wins with depth 0' do
          expect(options[0].evaluate(options[1], 0)).to eq(10)
        end

        it 'returns 5 if player is :o and wins with depth 5' do
          expect(options[0].evaluate(options[1], 5)).to eq(5)
        end

        it 'returns -10 if player loses with depth 0' do
          expect(options[0].evaluate(options[2], 0)).to eq(-10)
        end

        it 'returns -5 if player loses with depth 5' do
          expect(options[0].evaluate(options[2], 5)).to eq(-5)
        end

        it 'returns zero if tie regardless of depth' do
          expect(options[0].evaluate(options[3], 9)).to eq(0)
        end
      end
    end
  end
end
