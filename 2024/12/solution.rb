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

# represents a plot in the garden
class Plot
  attr_accessor :plant_locations, :perimeter
  attr_reader :plant

  def initialize(plant)
    @plant_locations = []
    @perimeter = 0
    @plant = plant
  end
end

def below_right_is_plot?(garden, plant, coordinates, p_coordinates)
  return false unless garden[coordinates.first + 1] && garden[coordinates.first + 1][coordinates.last] == plant

  right_is_plot?(garden, plant, [coordinates.first + 1, coordinates.last], p_coordinates)
end

def right_is_plot?(garden, plant, coordinates, p_coordinates)
  return false unless garden[coordinates.first][coordinates.last] == plant

  above_right_is_plot = garden[coordinates.first - 1][coordinates.last] == plant &&
                        p_coordinates.include?([coordinates.first - 1, coordinates.last])

  if above_right_is_plot ||
     below_right_is_plot?(garden, plant, [coordinates.first, coordinates.last + 1], p_coordinates)
    return true
  end

  right_is_plot?(garden, plant, [coordinates.first, coordinates.last + 1], p_coordinates)
end

# works for all examples not for puzzle -> 1285812

plots = []
garden = INPUT.each_line(chomp: true).map { |l| l.split("") }
garden.each_with_index do |row, row_index|
  current_plot = nil

  row.each_with_index do |plant, plant_index|
    current_plot = nil unless current_plot&.plant == plant

    puts "#{plant}: #{row_index}, #{plant_index}"

    unless current_plot
      existing_plot = plots.select { |plot| plot.plant == plant }
      if existing_plot.length
        current_plot = existing_plot.find do |l_plot|
          next false unless l_plot.plant == plant

          p_locations = l_plot.plant_locations

          left = [row_index, plant_index - 1]
          left_is_plot = garden[left.first][left.last] == plant && p_locations.include?(left)

          right = [row_index, plant_index + 1]
          right_is_plot = right_is_plot?(garden, plant, right, p_locations)

          above = [row_index - 1, plant_index]
          above_is_plot = garden[above.first][above.last] == plant && p_locations.include?(above)

          left_is_plot || right_is_plot || above_is_plot
        end

        if current_plot.nil?
          current_plot = Plot.new(plant)
          plots << current_plot
        end
      else
        current_plot = Plot.new(plant)
        plots << current_plot
      end
    end

    current_plot.plant_locations << [row_index, plant_index]

    [[0, 1], [0, -1], [1, 0], [-1, 0]].each do |x, y|
      new_x = row_index + x
      new_y = plant_index + y

      if new_x.negative? || new_y.negative? || new_x >= garden.length || new_y >= garden.first.length ||
         garden[new_x][new_y] != plant
        current_plot.perimeter += 1
      end
    end
  end
end

p plots.map { |plot| plot.plant_locations.count * plot.perimeter }.reduce(:+)
