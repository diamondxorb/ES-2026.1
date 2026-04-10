class WrongNumberOfPlayersError < StandardError ; end
class NoSuchStrategyError < StandardError ; end

def rps_game_winner(game)
  raise WrongNumberOfPlayersError unless game.length == 2

  p1_name, p1_strat = game[0]
  p2_name, p2_strat = game[1]

  p1_strat = p1_strat.upcase
  p2_strat = p2_strat.upcase

  valid_strats = ["R", "P", "S"]
  raise NoSuchStrategyError unless valid_strats.include?(p1_strat) && valid_strats.include?(p2_strat)

  win = {
    "R" => "S",
    "S" => "P",
    "P" => "R"
  }

  if p1_strat == p2_strat || win[p1_strat] == p2_strat
    return game[0]
  else
    return game[1]
  end

end

def rps_tournament_winner(tournament)
  if tournament.length == 2 && tournament.all? { |player| player.is_a?(Array) && player.length == 2 && player[0].is_a?(String) }
    return rps_game_winner(tournament)
  end
  
  left_winner = rps_tournament_winner(tournament[0])
  right_winner = rps_tournament_winner(tournament[1])
  
  rps_game_winner([left_winner, right_winner])
end


if __FILE__ == $PROGRAM_NAME
  game1 = [ ["Kristen", "P"], ["Pam", "S"] ]
  puts rps_game_winner(game1).inspect

  tournament = [
    [
      [["Kristen", "P"], ["Dave", "S"]],
      [["Richard","R"], ["Michael", "S"]]
    ],
    [
      [["Allen", "S"], ["Omer", "P"]],
      [["David E.", "R"], ["Richard X.", "P"]]
    ]
  ]

  puts rps_tournament_winner(tournament).inspect
end