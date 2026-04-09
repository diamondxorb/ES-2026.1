class WrongNumberOfPlayersError < StandardError ; end
class NoSuchStrategyError < StandardError ; end

def rps_game_winner(game)
  raise WrongNumberOfPlayersError unless game.length == 2

  p1_name, p1_strat = game[0]
  p2_name, p2_strat = game[1]

  p1_strat = p1_strat.upcase
  p2_strat = p2_strat.upcase

  valid_strats = ["R", "P", "S"]
  raise NoSuchStrategyError unless valid_strats.include?(p1_strat)
  raise NoSuchStrategyError unless valid_strats.include?(p2_strat)

  win = {
    "R" => "S",
    "S" => "P",
    "P" => "R"
  }

  if p1_strat == p2_strat
    return game[0]
  elsif win[p1_strat] == p2_strat
    return game[0]
  else
    return game[1]
  end

end

if __FILE__ == $PROGRAM_NAME
  game1 = [ ["Kristen", "P"], ["Pam", "S"] ]
  puts rps_game_winner(game1).inspect
end