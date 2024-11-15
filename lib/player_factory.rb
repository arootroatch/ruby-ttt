# frozen_string_literal: true

require_relative 'player/human_player'
require_relative 'player/easy'
require_relative 'player/unbeatable'
require_relative 'cli'

class PlayerFactory
  @players = {
    1 => HumanPlayer,
    2 => Easy,
    3 => Unbeatable
  }

  def self.set_player(num, token)
    CLI.prompt_player_selection(num)
    input = CLI.get_user_input(1, 3)
    create_player_instance(input, token)
  end

  def self.create_player_instance(input, token)
    @players[input].new(token)
  end
end
