# frozen_string_literal: true

require "matrix"
require "set"

# # score = 7036
# # count = 45
# INPUT = "###############
# #.......#....E#
# #.#.###.#.###.#
# #.....#.#...#.#
# #.###.#####.#.#
# #.#.#.......#.#
# #.#.#####.###.#
# #...........#.#
# ###.#.#####.#.#
# #...#.....#.#.#
# #.#.#.###.#.#.#
# #.....#...#.#.#
# #.###.#.#.#.#.#
# #S..#.....#...#
# ###############"

# score = 11048
# count = 64
INPUT = "#################
#...#...#...#..E#
#.#.#.#.#.#.#.#.#
#.#.#.#...#...#.#
#.#.#.#.###.#.#.#
#...#.#.#.....#.#
#.#.#.#.#.#####.#
#.#...#.#.#.....#
#.#.#####.#.###.#
#.#.#.......#...#
#.#.###.#####.###
#.#.#...#.....#.#
#.#.#.#####.###.#
#.#.#.........#.#
#.#.#.#########.#
#S#.............#
#################"

# start on S, facing east
# end on E
# move forward 1 tile at a time, except for walls (`#`), increases score by 1
# can rotate clockwise or counterclockwise at 90 degrees, increases score by 1000
# find the shortest path - what's the score

def find_path(matrix, start, goal, part_two)
  directions = {
    "N" => [-1, 0],
    "E" => [0, 1],
    "S" => [1, 0],
    "W" => [0, -1]
  }

  turns = {
    "N" => %w[W E],
    "E" => %w[N S],
    "S" => %w[E W],
    "W" => %w[S N]
  }

  visited = Set.new

  # Initial state: position, direction, path taken, and score
  queue = [[start, "E", [start], 0]]
  all_paths = []

  until queue.empty?
    # Sort the queue by score to prioritize the lowest-cost path
    queue.sort_by! { |_, _, _, score| score } unless part_two

    current, direction, path, score = queue.shift
    x, y = current

    next all_paths << { path: path, score: score }  if current == goal && part_two

    return { path: path, score: score } if current == goal && !part_two

    visit = part_two ? [current, direction, score] : [current, direction]
    next if visited.include?(visit)

    visited.add([current, direction])

    # Move forward in the current direction
    dx, dy = directions[direction]
    new_x = x + dx
    new_y = y + dy
    # add path if next move is not a wall
    if new_x.between?(0, matrix.row_count - 1) && new_y.between?(0, matrix.column_count - 1) &&
       matrix[new_x, new_y] != "#"
      queue << [[new_x, new_y], direction, path + [[new_x, new_y]], score + 1]
    end

    # Turn 90 degrees clockwise and counterclockwise
    turns[direction].each { |new_direction| queue << [current, new_direction, path, score + 1000] }
  end

  part_two ? all_paths : nil
end

start = []
goal = []
matrix = Matrix.rows(
  INPUT.each_line(chomp: true).each_with_index.map do |line, index|
    the_line = line.split("")
    start = [the_line.index("S"), index] if the_line.include?("S")
    goal = [the_line.index("E"), index] if the_line.include?("E")
    the_line
  end
)
part_one = find_path(matrix, start, goal, false)[:score]
p part_one

# not efficient enough
part_two = find_path(matrix, start, goal, true)
p part_two.count # not right
