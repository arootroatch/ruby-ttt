require_relative 'board/three_by_three'

class BoardFactory
  def self.create_board_instance
    ThreeByThree.new
  end
end