# frozen_string_literal: true

# INPUT = "....#.....
# .........#
# ..........
# ..#.......
# .......#..
# ..........
# .#..^.....
# ........#.
# #.........
# ......#..."

guard = nil
inputs = INPUT.each_line(chomp: true).each_with_index.map do |line, row_index|
  row = line.split("")
  guard_column_index = row.index("^")
  guard = [row_index, guard_column_index] if guard_column_index
  row
end

direction = [-1, 0]
# the start position counts
positions = [guard]
exhausted = false
until exhausted
  obstacle = false
  until obstacle
    guard_row_index = guard.first + direction.first
    break exhausted = true if guard_row_index.negative? || guard_row_index >= inputs.count

    guard_column_index = guard.last + direction.last
    break exhausted = true if guard_column_index.negative? || guard_column_index >= inputs.first.count

    current = inputs[guard_row_index][guard_column_index]
    if current == "#"
      obstacle = true
    else
      guard = [guard_row_index, guard_column_index]
      positions << guard
    end
  end
  direction = {
    [-1, 0] => [0, 1],
    [0, 1] => [1, 0],
    [1, 0] => [0, -1],
    [0, -1] => [-1, 0]
  }[direction]
end

p positions.uniq.count
