# frozen_string_literal: true

require "set"
require_relative "../../util"

# INPUT = "5,4
# 4,2
# 4,5
# 3,0
# 2,1
# 6,3
# 2,4
# 1,5
# 0,6
# 3,3
# 2,6
# 5,1
# 1,2
# 5,5
# 2,5
# 6,5
# 1,4
# 0,4
# 6,4
# 1,1
# 6,1
# 1,0
# 0,5
# 1,6
# 2,0"
# grid_size = 7
# how_many_bytes = 11 # 0 indexed

def breadth_first_search(matrix)
  directions = [[-1, 0], [0, 1], [1, 0], [0, -1]]
  visited = Set.new
  queue = [[[0, 0], 0]]
  until queue.empty?
    current, distance = queue.shift

    return distance if current == [matrix.first.count - 1, matrix.count - 1]

    next if visited.include?(current)

    visited.add(current)

    directions.each do |direction|
      new_x = current.first + direction.first
      next if new_x.negative? || new_x >= matrix.first.count

      new_y = current.last + direction.last
      next if new_y.negative? || new_y >= matrix.count

      next if matrix[new_y][new_x] == "#"

      queue << [[new_x, new_y], distance + 1]
    end
  end
  nil
end

grid_size = 71
how_many_bytes = 1023 # 0 indexed
matrix = simple_matrix(grid_size, grid_size, ".")
coordinates_of_bytes = INPUT.each_line(chomp: true).map { |line| line.split(",").map(&:to_i) }

(0..how_many_bytes).each do |i|
  coords = coordinates_of_bytes[i]
  matrix[coords.last][coords.first] = "#"
end

# part one
p breadth_first_search(matrix)

# part two
path_still_good = true
while path_still_good
  how_many_bytes += 1
  coords = coordinates_of_bytes[how_many_bytes]
  matrix[coords.last][coords.first] = "#"
  path_still_good = breadth_first_search(matrix)
end
p coordinates_of_bytes[how_many_bytes]
