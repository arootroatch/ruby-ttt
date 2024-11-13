# frozen_string_literal: true

class Player
  attr_reader :token, :type

  def take_turn
    raise('not implemented')
  end
end
