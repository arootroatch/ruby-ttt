require "three_by_three"

describe "3x3 game.rb board" do
  before(:each) do
    @board = ThreeByThree.new
  end

  it "creates instance of game.rb board" do
    expect(@board.get_board ).to eq([0, 1, 2, 3, 4, 5, 6, 7, 8])
  end

  it "updates board with move" do
    @board.update(:x, 4)
    expect(@board.get_board).to eq([0, 1, 2, 3, :x, 5, 6, 7, 8])
    @board.update(:o, 0)
    expect(@board.get_board).to eq([:o, 1, 2, 3, :x, 5, 6, 7, 8])
  end

  it "returns available moves" do
    @board.update(:x, 4)
    @board.update(:o, 0)
    expect(@board.available_moves).to eq([1, 2, 3, 5, 6, 7, 8])
  end

  it "divides board into winning paths" do
    expect(@board.to_paths).to eq([[0, 1, 2], [3, 4, 5], [6, 7, 8],
                                   [0, 3, 6], [1, 4, 7], [2, 5, 8],
                                   [0, 4, 8], [2, 4, 6]])
  end

  context "scoring" do
    it "game.rb not over" do
      expect(@board.score).to eq(:in_progress)
    end

    it 'scores X winning horizontally' do
      @board.update(:x, 0)
      @board.update(:o, 4)
      @board.update(:x, 1)
      @board.update(:o, 3)
      @board.update(:x, 2)
      expect(@board.score).to eq(:x_wins)
    end

    it 'scores O winning horizontally' do
      @board.update(:o, 0)
      @board.update(:x, 4)
      @board.update(:o, 1)
      @board.update(:x, 3)
      @board.update(:o, 2)
      expect(@board.score).to eq(:o_wins)
    end

    it 'scores X winning vertically' do
      @board.update(:x, 0)
      @board.update(:o, 1)
      @board.update(:x, 3)
      @board.update(:o, 2)
      @board.update(:x, 6)
      expect(@board.score).to eq(:x_wins)
    end

    it 'scores O winning vertically' do
      @board.update(:o, 0)
      @board.update(:x, 1)
      @board.update(:o, 3)
      @board.update(:x, 2)
      @board.update(:o, 6)
      expect(@board.score).to eq(:o_wins)
    end

    it 'scores X winning diagonally' do
      @board.update(:x, 0)
      @board.update(:o, 1)
      @board.update(:x, 4)
      @board.update(:o, 2)
      @board.update(:x, 8)
      expect(@board.score).to eq(:x_wins)
    end

    it 'scores O winning diagonally' do
      @board.update(:o, 0)
      @board.update(:x, 1)
      @board.update(:o, 4)
      @board.update(:x, 2)
      @board.update(:o, 8)
      expect(@board.score).to eq(:o_wins)
    end

    it 'scores tie game.rb' do
      @board.update(:x, 0)
      @board.update(:o, 1)
      @board.update(:x, 2)
      @board.update(:o, 3)
      @board.update(:x, 4)
      @board.update(:x, 5)
      @board.update(:o, 6)
      @board.update(:x, 7)
      @board.update(:o, 8)
      expect(@board.score).to eq(:tie)
    end

  end
end