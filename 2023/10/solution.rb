# frozen_string_literal: true

require_relative "../../util"

# # 4
# INPUT = ".....
# .S-7.
# .|.|.
# .L-J.
# ....."

# # 8
# INPUT = "..F7.
# .FJ|.
# SJ.L7
# |F--J
# LJ..."

=begin
. . . . . . . . . . .
. S - - - - - - - 7 .
. | F - - - - - 7 | .
. | | . . . . . | | .
. | | . . . . . | | .
. | L - 7 . F - J | .
. | + + | . | + + | .
. L - - J . L - - J .
. . . . . . . . . . .
=end


INPUT = "...........
.S-------7.
.|F-----7|.
.||.....||.
.||.....||.
.|L-7.F-J|.
.|..|.|..|.
.L--J.L--J.
..........."

=begin
. F - - - - 7 F 7 F 7 F 7 F - 7 . . . .
. | F - - 7 | | | | | | | | F J . . . .
. | | . F J | | | | | | | | L 7 . . . .
F J L 7 L 7 L J L J | | L J + L - 7 . .
L - - J . L 7 + + + L J S 7 F - 7 L 7 .
. . . . F - J + + F 7 F J | L 7 L 7 L 7
. . . . L 7 + F 7 | | L 7 | + L 7 L 7 |
. . . . . | F J L J | F J | F 7 | . L J
. . . . F J L - 7 . | | . | | | | . . .
. . . . L - - - J . L J . L J L J . . .
=end

# INPUT = ".F----7F7F7F7F-7....
# .|F--7||||||||FJ....
# .||.FJ||||||||L7....
# FJL7L7LJLJ||LJ.L-7..
# L--J.L7...LJS7F-7L7.
# ....F-J..F7FJ|L7L7L7
# ....L7.F7||L7|.L7L7|
# .....|FJLJ|FJ|F7|.LJ
# ....FJL-7.||.||||...
# ....L---J.LJ.LJLJ..."

# INPUT = "FF7FSF7F7F7F7F7F---7
# L|LJ||||||||||||F--J
# FL-7LJLJ||||||LJL-77
# F--JF--7||LJLJ7F7FJ-
# L---JF-JLJ.||-FJLJJ7
# |F|F-JF---7F7-L7L|7|
# |FFJF7L7F-JF7|JL---7
# 7-L-JL7||F7|L7F-7F7|
# L.L7LFJ|||||FJL7||LJ
# L7JLJL-JLJLJL--JLJ.L"

# direction of travel is the previous move's change in [x, y]
def next_pipe_change(current_pipe, direction_of_travel)
  {
    "|" => [0, direction_of_travel.last],
    "-" => [direction_of_travel.first, 0],
    "L" => if direction_of_travel == [-1, 0]
             [0, -1]
           elsif direction_of_travel == [0, 1]
             [1, 0]
           end,
    "J" => if direction_of_travel == [0, 1]
             [-1, 0]
           elsif direction_of_travel == [1, 0]
             [0, -1]
           end,
    "7" => if direction_of_travel == [1, 0]
             [0, 1]
           elsif direction_of_travel == [0, -1]
             [-1, 0]
           end,
    "F" => if direction_of_travel == [0, -1]
             [1, 0]
           elsif direction_of_travel == [-1, 0]
             [0, 1]
           end
  }[current_pipe]
end

chomped = INPUT.each_line.map(&:chomp)
matrix = simple_matrix(chomped.count, chomped.first.length)
start = nil
chomped.each_with_index do |line, row_index|
  line.split("").each_with_index do |char, col_index|
    start = [col_index, row_index] if char == "S"
    matrix[row_index][col_index] = char
  end
end

starts = []
[[0, -1], [0, 1], [1, 0], [-1, 0]].each do |coords|
  backwards_off_the_cliff = (start.first == 0 && coords.first == -1) || (start.last == 0 && coords.last == -1)
  forward_off_the_cliff = (start.first == matrix.first.count - 1 && coords.first == 1) || (start.last >= matrix.count - 1 && coords.last == 1)
  next if backwards_off_the_cliff || forward_off_the_cliff
  x = start.first + coords.first
  y = start.last + coords.last
  neighbor = matrix[y][x]
  starts << [x, y, next_pipe_change(neighbor, coords)] unless neighbor == "."
end

pipe_coords = nil
p1_counts = starts.map do |x, y, next_move|
  next if next_move.nil?
  count = 0
  complete = false
  counts = []
  pipe_coords = [start]
  until complete
    pipe_coords << [x, y]
    y += next_move.last
    x += next_move.first
    char = matrix[y][x]
    next_move = next_pipe_change(char, [next_move.first, next_move.last])
    complete = !!(char == "S")
    count += 1
    counts << count
  end
  counts
end.compact

p1 = p1_counts.first.zip(p1_counts.last.reverse).map { |forward, backward| [forward, backward].min }.max

pp p1

# if every tile not in the pipe is contained within the pipe, this is the absolute maximum
# note: this is not true
cannot_be_higher_than_this = [matrix.first.count, matrix.count].reduce(:*) - pipe_coords.count

contained_coords = []
out_of_bounds_coords = []
pipe_coords.each_with_index do |coord, index|
  pp "coord: #{coord}"
  next_index = pipe_coords[index + 1].nil? ? 0 : index + 1
  x_diff = pipe_coords[next_index].first - coord.first
  y_diff = pipe_coords[next_index].last - coord.last
  direction = x_diff.zero? ? "y" : "x"
  y_direction = 0
  x_direction = 0
  if direction == "x"
    loop do
      next_index += pipe_coords[next_index + 1].nil? ? 0 : 1
      y_diff = pipe_coords[next_index].last - coord.last
      if !y_diff.zero?
        y_direction = y_diff
        break
      end
    end
  elsif direction == "y"
    loop do
      next_index += pipe_coords[next_index + 1].nil? ? 0 : 1
      x_diff = pipe_coords[next_index].last - coord.last
      if !x_diff.zero?
        x_direction = x_diff
        break
      end
    end
  else
    pp "FAIL"
  end
  pp "x_dir, y_dir #{[x_direction, y_direction]}"
  boundary_hit = false
  local_coords = []
  x, y = coord
  until boundary_hit
    x += x_direction
    y += y_direction
    pp [x, y]
    if x == -1 || x >= (matrix.first.count - 1) || y == -1 || y >= (matrix.count - 1) || out_of_bounds_coords.include?([x, y])
      out_of_bounds_coords.concat(local_coords)
      boundary_hit = true
    elsif pipe_coords.include?([x, y]) || contained_coords.include?([x, y])
      contained_coords.concat(local_coords)
      boundary_hit = true
    else
      local_coords << [x, y]
    end
  end
end

pp contained_coords
