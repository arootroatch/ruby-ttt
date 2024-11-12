require_relative 'player/human_player'
require_relative 'player/easy'
require_relative 'player/minimax'
require_relative 'cli'

class PlayerFactory
  def self.set_player(n, token)
    CLI.prompt_player_selection(n)
    input = CLI.get_user_input(1, 3)
    create_player_instance(input, token)
  end

  # TODO add testing for this
  def self.create_player_instance(input, token)
    if input == 1
      HumanPlayer.new(token)
    elsif input == 2
      Easy.new(token)
    elsif input == 3
      Minimax.new(token)
    end
  end
end