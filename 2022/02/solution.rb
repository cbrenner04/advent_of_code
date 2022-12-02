# frozen_string_literal: true

# first column
# A == rock
# B == paper
# C == scissors

# second column
# X == rock
# Y == paper
# Z == scissors

# scoring
# 1 for Rock, 2 for Paper, and 3 for Scissors
# plus
# 0 if you lost, 3 if the round was a draw, and 6 if you won

# Rock beats Scissors -> (C X) 3 - 1 = 2 || (A Z) 1 - 3 = -2
# Paper beats Rock -> (A Y) 1 - 2 = -1 || (B X) 2 - 1 = 1
# Scissors beats Paper -> (B Z) 2 - 3 = -1 || (C Y) 3 - 2 = 1

# INPUT = "A Y
# B X
# C Z"

part_1 = INPUT.each_line.map do |line|
  play = line.chomp
  score = if ["C X", "A Y", "B Z"].include? play
            6
          elsif ["A Z", "B X", "C Y"].include? play
            0
          else
            3
          end
  _, me = line.split
  score + if me == "X"
            1
          else
            (me == "Y" ? 2 : 3)
          end
end.reduce("+")

p part_1

# X -> lose
# Y -> tie
# Z -> win

part_2 = INPUT.each_line.map do |line|
  opponent, outcome = line.split
  case outcome
  when "X"
    case opponent
    when "A"
      3
    when "B"
      1
    else
      2
    end
  when "Y"
    case opponent
    when "A"
      4
    when "B"
      5
    else
      6
    end
  else
    case opponent
    when "A"
      8
    when "B"
      9
    else
      7
    end
  end
end.reduce(:+)

p part_2
