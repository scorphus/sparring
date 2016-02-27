require_relative 'player'
require_relative 'team'

players = [
  Player.new('Douglass', 18, 4.98),
  Player.new('William', 15, 3.26),
  Player.new('Lynn', 33, 3.47),
  Player.new('Justin', 26, 3.75),
  Player.new('Lee', 32, 4.51),
  Player.new('Clint', 36, 2.27),
  Player.new('Nicholas', 27, 2.18),
  Player.new('Andre', 24, 2.46),
  Player.new('Ramon', 16, 2.71),
  Player.new('Arno', 19, 2.27),
  Player.new('Ryann', 23, 3.88),
  Player.new('Dalton', 27, 2.32),
  Player.new('Mario', 26, 2.90),
  Player.new('Russell', 37, 2.38),
  Player.new('Lynn', 31, 4.01),
  Player.new('Madison', 28, 3.15),
  Player.new('Virgil', 29, 3.84),
  Player.new('Damian', 35, 2.70),
]

red_team = Team.new('Red')
red_team.add_players(*players)

elig_players = red_team.select { |p| (20...30) === p.age}
                       .reject { |p| p.skill_level < 3 }

puts red_team
puts elig_players
