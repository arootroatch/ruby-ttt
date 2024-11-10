module CLI

  $end_states = {
    :x_wins => "X wins!",
    :o_wins => "O wins!",
    :tie => "It's a tie!"
  }

  def self.print_board(board)
    formatted = board.map { |e| e.to_s.capitalize }
    puts "#{formatted[0]} #{formatted[1]} #{formatted[2]}"
    puts "#{formatted[3]} #{formatted[4]} #{formatted[5]}"
    puts "#{formatted[6]} #{formatted[7]} #{formatted[8]}"
  end

  def self.display_turn(token)
    puts token.to_s.capitalize + "'s turn!"
  end

  def self.prompt_move(board)
    puts "Please enter your move (type a number 0-#{board.length - 1} and press 'Enter'):"
  end

  def self.alert_invalid_move(board)
    available = board.available_moves
    puts "That square is taken! Please enter an available square #{available}:\n"
  end

  def self.get_user_input(max)
    input = gets.chomp
    parsed = Integer(input, exception: false)
    if parsed and parsed <= max
      parsed
    else
      puts "Oops! Please enter a number from 0 to #{max}:"
      get_user_input(max)
    end
  end

  def self.print_result(state)
    puts $end_states[state]
  end

end