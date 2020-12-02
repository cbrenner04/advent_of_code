# frozen_string_literal: true

data = INPUT.split("\n")

part_one = 0
part_two = 0

data.each do |line|
  rule, pass = line.split(": ")
  counts, letter = rule.split(" ")

  # part one
  min, max = counts.split("-")
  count_of_letter = pass.count(letter)
  part_one += 1 if count_of_letter >= min.to_i && count_of_letter <= max.to_i

  # part two
  first = pass[min.to_i - 1]
  second = pass[max.to_i - 1]
  part_two += 1 if (first == letter || second == letter) && first != second
end

puts part_one
puts part_two
