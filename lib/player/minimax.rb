require_relative 'player'

class Minimax < Player

  def initialize(token)
    @token = token
    @type = :minimax
  end

end