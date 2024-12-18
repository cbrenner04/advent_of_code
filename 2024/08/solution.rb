# frozen_string_literal: true

require "matrix"
require "set"

# for `diagonal`
require_relative "../../util"

INPUT = "............
........0...
.....0......
.......0....
....0.......
......A.....
............
............
........A...
.........A..
............
............"

# none of this is right

# splitted = INPUT.each_line(chomp: true).map { |line| line.split("") }
# matrix = Matrix.rows(splitted)

# rows = matrix.row_vectors.map(&:to_a)
# columns = matrix.column_vectors.map(&:to_a)
# diags = []

# (1..matrix.row_count).each do |i|
#   (1..matrix.column_count).each do |j|
#     diags << diagonals(matrix, { row_step: i, column_step: j })
#   end
# end

# def check_vector(vector)
#   count = 0
#   max_index = vector.count - 1
#   match = vector.join.scan(/\w{2}/)

#   match.each do |m|
#     next unless m && m[0] == m[1]

#     indexes = vector.each_index.select { |i| vector[i] == m[0] }
#     count += 1 if (indexes.first - 1) >= 0
#     count += 1 if (indexes.last + 1) <= max_index
#   end
#   count
# end

# count = 0
# rows.concat(columns).each do |vector|
#   next if vector.count < 3

#   count += check_vector(vector)
# end

# diags.each do |diag|
#   diag.each do |d|
#     next if d.count < 3

#     count += check_vector(d)
#   end
# end

# p count


# gpt'ed - turns out i didn't understand the problem which makes sense why i couldn't solve it

# Find all antennas and their positions
def find_antennas(matrix)
  antennas = Hash.new { |hash, key| hash[key] = [] }
  matrix.each_with_index do |row, r|
    row.each_with_index do |cell, c|
      antennas[cell] << [r, c] if cell =~ /[a-zA-Z0-9]/
    end
  end
  antennas
end

# Check if a position is within the grid bounds
def in_bounds?(matrix, row, col)
  row >= 0 && row < matrix.length && col >= 0 && col < matrix[0].length
end

# Calculate all antinode positions for pairs of antennas with the same frequency
def calculate_antinodes(matrix)
  antennas = find_antennas(matrix)
  antinodes = Set.new

  antennas.each_value do |positions|
    positions.combination(2).each do |(r1, c1), (r2, c2)|
      # Calculate the potential antinode positions
      dr = r2 - r1
      dc = c2 - c1

      # Positions for the antinodes on both sides
      antinode1 = [r1 - dr, c1 - dc]
      antinode2 = [r2 + dr, c2 + dc]

      # Add the antinodes if they are within bounds
      antinodes.add(antinode1) if in_bounds?(matrix, *antinode1)
      antinodes.add(antinode2) if in_bounds?(matrix, *antinode2)
    end
  end

  antinodes
end

matrix = INPUT.each_line(chomp: true).map { |line| line.split("") }
# Run the function on the sample matrix
p calculate_antinodes(matrix).count
