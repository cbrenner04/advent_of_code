# frozen_string_literal: true

# INPUT = "#####
# .####
# .####
# .####
# .#.#.
# .#...
# .....

# #####
# ##.##
# .#.##
# ...##
# ...#.
# ...#.
# .....

# .....
# #....
# #....
# #...#
# #.#.#
# #.###
# #####

# .....
# .....
# #.#..
# ###..
# ###.#
# ###.#
# #####

# .....
# .....
# .....
# #....
# #.#..
# #.#.#
# #####"

# keys and locks are 0,0 to 4,6
matrixes = INPUT.split("\n\n").map { |matrix| matrix.each_line(chomp: true).map { |line| line.split("") } }
items = []
matrixes.each do |matrix|
  type = matrix.first.count("#") == 5 ? "lock" : "key"
  heights = Array.new(5, 0)
  matrix.each_with_index do |m, i|
    next if (i.zero? && type == "lock") || (i == 6 && type == "key")

    m.each_with_index { |char, j| heights[j] += 1 if char == "#" }
  end
  items << {
    type: type,
    matrix: matrix,
    heights: heights
  }
end
grouped = items.group_by { |item| item[:type] }
valid_combinations = 0
grouped["lock"].each do |lock|
  grouped["key"].each do |key|
    valid = lock[:heights].each_with_index.map { |l, i| l + key[:heights][i] <= 5 }
    next if valid.any?(false)

    valid_combinations += 1
  end
end
p valid_combinations
