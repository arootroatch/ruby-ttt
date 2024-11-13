# frozen_string_literal: true

require 'board/three_by_three'
require 'board/board'

describe ThreeByThree do
  before(:each) do
    @board = ThreeByThree.new
  end

  it { expect(described_class).to be < Board }

  it 'creates instance of game.rb board' do
    expect(@board.board).to eq([0, 1, 2, 3, 4, 5, 6, 7, 8])
  end

  it 'updates board with move' do
    @board.update(:x, 4)
    expect(@board.board).to eq([0, 1, 2, 3, :x, 5, 6, 7, 8])
    @board.update(:o, 0)
    expect(@board.board).to eq([:o, 1, 2, 3, :x, 5, 6, 7, 8])
  end

  it 'returns available moves' do
    @board.update(:x, 4)
    @board.update(:o, 0)
    expect(@board.available_moves).to eq([1, 2, 3, 5, 6, 7, 8])
  end

  it 'divides board into winning paths' do
    expect(@board.to_paths).to eq([[0, 1, 2], [3, 4, 5], [6, 7, 8],
                                   [0, 3, 6], [1, 4, 7], [2, 5, 8],
                                   [0, 4, 8], [2, 4, 6]])
  end

  context 'scoring' do
    it 'game.rb not over' do
      expect(@board.score).to eq(:in_progress)
    end

    [['X', :x, :o, :x_wins], ['O', :o, :x, :o_wins]].map do |arr|
      it "scores #{arr[0]} winning horizontally" do
        @board.update(arr[1], 0)
        @board.update(arr[2], 4)
        @board.update(arr[1], 1)
        @board.update(arr[2], 3)
        @board.update(arr[1], 2)
        expect(@board.score).to eq(arr[3])
      end
    end

    [['X', :x, :o, :x_wins], ['O', :o, :x, :o_wins]].map do |arr|
      it "scores #{arr[0]} winning vertically" do
        @board.update(arr[1], 0)
        @board.update(arr[2], 1)
        @board.update(arr[1], 3)
        @board.update(arr[2], 2)
        @board.update(arr[1], 6)
        expect(@board.score).to eq(arr[3])
      end
    end

    [['X', :x, :o, :x_wins], ['O', :o, :x, :o_wins]].map do |arr|
      it "scores #{arr[0]} winning diagonally" do
        @board.update(arr[1], 0)
        @board.update(arr[2], 1)
        @board.update(arr[1], 4)
        @board.update(arr[2], 2)
        @board.update(arr[1], 8)
        expect(@board.score).to eq(arr[3])
      end
    end

    it 'scores full board with winner' do
      build_x_wins_full_board(@board)
      expect(@board.score).to eq(:x_wins)
    end

    it 'scores tie game.rb' do
      build_tie_game_board(@board)
      expect(@board.score).to eq(:tie)
    end
  end
end
