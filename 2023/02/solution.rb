# frozen_string_literal: true

# INPUT = "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
# Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
# Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
# Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
# Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green"

maxes = {
  "red" => 12,
  "green" => 13,
  "blue" => 14
}

p1 = INPUT.each_line.map do |line|
  game, combos = line.chomp.split(": ")
  sets = combos.split("; ")
  each = sets.map { |set| set.split(", ") }.flatten
  something = each.map do |e|
    count, type = e.split
    count.to_i > maxes[type] ? "impossible" : "possible"
  end
  something.any? { |s| s == "impossible" } ? nil : game.split.last.to_i
end.compact.reduce(:+)

puts p1

p2 = INPUT.each_line.map do |line|
  game, combos = line.chomp.split(": ")
  sets = combos.split("; ")
  each = sets.map { |set| set.split(", ") }.flatten
  counts = {
    "red" => 0,
    "green" => 0,
    "blue" => 0
  }
  each.each do |e|
    count, type = e.split
    counts[type] = count.to_i if count.to_i > counts[type]
  end
  counts.values.reduce(:*)
end.reduce(:+)

puts p2
