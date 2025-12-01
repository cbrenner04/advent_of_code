# frozen_string_literal: true

# INPUT = "AAAA
# BBCD
# BBCC
# EEEC"

# area * perimeter
# A = 4 * 10 =  40
# B = 4 *  8 =  32
# C = 4 * 10 =  40
# D = 1 *  4 =   4
# E = 3 *  8 =  24
#      Total = 140

# INPUT = "OOOOO
# OXOXO
# OOOOO
# OXOXO
# OOOOO"

# O = 21 * 36 = 756
# X =  1 *  4 =   4
# X =  1 *  4 =   4
# X =  1 *  4 =   4
# X =  1 *  4 =   4
#       Total = 772

# INPUT = "RRRRIICCFF
# RRRRIICCCF
# VVRRRCCFFF
# VVRCCCJFFF
# VVVVCJJCFE
# VVIVCCJJEE
# VVIIICJJEE
# MIIIIIJJEE
# MIIISIJEEE
# MMMISSJEEE"

# R = 12 * 18 =  216
# I =  4 *  8 =   32
# C = 14 * 28 =  392
# F = 10 * 18 =  180
# V = 13 * 20 =  260
# J = 11 * 20 =  220
# C =  1 *  4 =    4
# E = 13 * 18 =  234
# I = 14 * 22 =  308
# M =  5 * 12 =   60
# S =  3 *  8 =   24
#       Total = 1930

# # represents a plot in the garden
# class Plot
#   attr_accessor :plant_locations, :perimeter
#   attr_reader :plant

#   def initialize(plant)
#     @plant_locations = []
#     @perimeter = 0
#     @plant = plant
#   end
# end

# def below_right_is_plot?(garden, plant, coordinates, p_coordinates)
#   return false unless garden[coordinates.first + 1] && garden[coordinates.first + 1][coordinates.last] == plant

#   right_is_plot?(garden, plant, [coordinates.first + 1, coordinates.last], p_coordinates)
# end

# def right_is_plot?(garden, plant, coordinates, p_coordinates)
#   return false unless garden[coordinates.first][coordinates.last] == plant

#   above_right_is_plot = garden[coordinates.first - 1][coordinates.last] == plant &&
#                         p_coordinates.include?([coordinates.first - 1, coordinates.last])

#   if above_right_is_plot ||
#      below_right_is_plot?(garden, plant, [coordinates.first, coordinates.last + 1], p_coordinates)
#     return true
#   end

#   right_is_plot?(garden, plant, [coordinates.first, coordinates.last + 1], p_coordinates)
# end

# # works for all examples not for puzzle -> 1285812

# plots = []
# garden = INPUT.each_line(chomp: true).map { |l| l.split("") }
# garden.each_with_index do |row, row_index|
#   current_plot = nil

#   row.each_with_index do |plant, plant_index|
#     current_plot = nil unless current_plot&.plant == plant

#     unless current_plot
#       existing_plot = plots.select { |plot| plot.plant == plant }
#       if existing_plot.count
#         current_plot = existing_plot.find do |l_plot|
#           next false unless l_plot.plant == plant

#           p_locations = l_plot.plant_locations

#           left = [row_index, plant_index - 1]
#           left_is_plot = garden[left.first][left.last] == plant && p_locations.include?(left)

#           right = [row_index, plant_index + 1]
#           right_is_plot = right_is_plot?(garden, plant, right, p_locations)

#           above = [row_index - 1, plant_index]
#           above_is_plot = garden[above.first][above.last] == plant && p_locations.include?(above)

#           left_is_plot || right_is_plot || above_is_plot
#         end

#         if current_plot.nil?
#           current_plot = Plot.new(plant)
#           plots << current_plot
#         end
#       else
#         current_plot = Plot.new(plant)
#         plots << current_plot
#       end
#     end

#     current_plot.plant_locations << [row_index, plant_index]

#     [[0, 1], [0, -1], [1, 0], [-1, 0]].each do |x, y|
#       new_x = row_index + x
#       new_y = plant_index + y

#   plots = []
#   garden = INPUT.each_line(chomp: true).map { |l| l.split("") }
#   garden.each_with_index do |row, row_index|
#   current_plot = nil

# p plots.map { |plot| plot.plant_locations.count * plot.perimeter }.reduce(:+)

# gpt'ed - basically bfs instead of the class based naive approach above
DIRECTIONS = [[0, 1], [1, 0], [0, -1], [-1, 0]].freeze
GARDEN = INPUT.each_line(chomp: true).map(&:chars).freeze
ROWS = GARDEN.count.freeze
COLUMNS = GARDEN.first.count.freeze

def flood_fill(visited, start_row, start_col)
  plant = GARDEN[start_row][start_col]
  queue = [[start_row, start_col]]
  area = 0
  perimeter = 0

  until queue.empty?
    row, col = queue.pop
    next if visited[row][col]

    visited[row][col] = true
    area += 1

    DIRECTIONS.each do |dr, dc|
      new_row = row + dr
      new_col = col + dc

      if !new_row.between?(0, ROWS - 1) || !new_col.between?(0, COLUMNS - 1) || GARDEN[new_row][new_col] != plant
        # Out of bounds or a different plant contributes to the perimeter
        perimeter += 1
      elsif !visited[new_row][new_col] && GARDEN[new_row][new_col] == plant
        # Add unvisited same-plant cell to the queue
        queue.push([new_row, new_col])
      end
    end
  end

  [area, perimeter]
end

part_one = 0
visited = Array.new(ROWS) { Array.new(COLUMNS, false) }

ROWS.times do |row|
  COLUMNS.times do |col|
    next if visited[row][col]

    area, perimeter = flood_fill(visited, row, col)
    part_one += area * perimeter
  end
end

puts part_one

def calculate_boundaries(cells)
  unique_sides = Set.new

  cells.each do |r, c|
    # Check each direction for boundaries
    DIRECTIONS.each_with_index do |(dr, dc), i|
      nr = r + dr
      nc = c + dc
      next unless !nr.between?(0, ROWS - 1) || !nc.between?(0, COLUMNS - 1) || GARDEN[nr][nc] != GARDEN[r][c]

      # Add boundary as a unique segment
      i.even? ? unique_sides.add([r, [c, nc].min, [c, nc].max]) : unique_sides.add([[r, nr].min, c, [r, nr].max])
    end
  end

  unique_sides.size
end

def bfs(r, c, visited)
  plant_type = GARDEN[r][c]
  cells = []
  queue = [[r, c]]
  visited[r][c] = true

  until queue.empty?
    current_r, current_c = queue.shift
    cells << [current_r, current_c]

    # Check all directions for boundaries
    DIRECTIONS.each do |dr, dc|
      nr = current_r + dr
      nc = current_c + dc
      next unless nr.between?(0, ROWS - 1) && nc.between?(0, COLUMNS - 1) && !visited[nr][nc] &&
                  GARDEN[nr][nc] == plant_type

      visited[nr][nc] = true
      queue << [nr, nc]
    end
  end

  cells
end

part_two = 0
visited = Array.new(ROWS) { Array.new(COLUMNS, false) }

# Iterate through each cell to identify regions
ROWS.times do |row|
  COLUMNS.times do |col|
    next if visited[row][col]

    # Perform BFS for the new region
    cells = bfs(row, col, visited)
    area = cells.count
    sides = calculate_boundaries(cells)
    part_two += area * sides
  end
end

# Output the total price
puts part_two
# previous: 1209946 - too high
# current: 1516859 - too high
