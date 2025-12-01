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

# row offset, column offset
DIRECTIONS = [[-1, 0], [0, 1], [1, 0], [0, -1]].freeze

def parse_input(input)
  guard = nil
  grid = input.each_line(chomp: true).each_with_index.map do |line, row_index|
    row = line.split("")
    guard_column_index = row.index("^")
    guard = [row_index, guard_column_index] if guard_column_index
    row
  end
  [grid, guard]
end

def next_position(pos, direction)
  [pos.first + direction.first, pos.last + direction.last]
end

def within_bounds?(position, grid)
  position.first.between?(0, grid.count) && position.last.between?(0, grid.first.count)
end

# updated with help from chat gpt to make more performant and work for part two
def simulate(grid, guard, add_obstruction = nil, detect_loops = false)
  visited = Set.new
  direction_index = 0
  guard_position = guard

  # Add the initial position to visited for part one
  visited.add(guard_position)

  loop do
    # Calculate the next position
    next_pos = next_position(guard_position, DIRECTIONS[direction_index])

    # Check if the next position is out of bounds
    return visited.count unless within_bounds?(next_pos, grid)

    # Handle obstructions
    if add_obstruction && next_pos == add_obstruction
      return :loop_detected if detect_loops

      next
    end

    # Check if the next position is an obstacle
    if grid[next_pos.first][next_pos[1]] == "#"
      # Turn right
      direction_index = (direction_index + 1) % 4
    else
      # Move forward
      guard_position = next_pos

      # Detect loops for part two
      if detect_loops
        state = [guard_position, direction_index]
        return :loop_detected if visited.include?(state)

        visited.add(state)
      else
        visited.add(guard_position)
      end
    end
  end
end

# taken from chat gpt - doesn't work. did a few back and forth but didn't get it yet
def part_two(grid, guard)
  loop_positions = []

  # Get bounds for potential obstruction placement
  (0...grid.count).each do |row_idx|
    (0...grid.first.count).each do |col_idx|
      pos = [row_idx, col_idx]

      # Skip known obstacles, guard's starting position, and edge positions
      next if grid[row_idx][col_idx] == "#" || pos == guard
      next unless row_idx.between?(0, grid.count) || col_idx.between?(0, grid.first.count)

      # Simulate with an obstruction at the current position
      result = simulate(grid, guard, pos, detect_loops: true)

      loop_positions << pos if result == :loop_detected
    end
  end

  loop_positions.count
end

grid, guard = parse_input(INPUT)
p simulate(grid, guard)
p part_two(grid, guard)

# # original working solution for part one that would not be performant enough for part two
# direction = [-1, 0]
# # the start position counts
# positions = [guard]
# exhausted = false
# until exhausted
#   obstacle = false
#   until obstacle
#     position = next_position(guard, direction)
#     break exhausted = true unless within_bounds?(position, grid)

#     current = grid[position.first][position.last]
#     if current == "#"
#       obstacle = true
#     else
#       guard = position
#       positions << guard
#     end
#   end
#   direction = {
#     [-1, 0] => [0, 1],
#     [0, 1] => [1, 0],
#     [1, 0] => [0, -1],
#     [0, -1] => [-1, 0]
#   }[direction]
# end

# p positions.uniq.count
