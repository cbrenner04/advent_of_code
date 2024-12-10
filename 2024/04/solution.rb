# frozen_string_literal: true

require "matrix"
# for `diagonal`
require_relative "../../util"

# INPUT = "MMMSXXMASM
# MSAMXMSMSA
# AMXSXMAAMM
# MSAMASMSMX
# XMASAMXAMM
# XXAMMXXAMA
# SMSMSASXSS
# SAXAMASAAA
# MAMMMXMMMM
# MXMXAXMASX"

part_one = 0

splitted = INPUT.each_line.map { |line| line.chomp.split("") }
matrix = Matrix.rows(splitted)

matrix.row_vectors.each do |row|
  part_one += row.to_a.join.scan(/XMAS/).count
  part_one += row.to_a.reverse.join.scan(/XMAS/).count
end
matrix.column_vectors.each do |column|
  part_one += column.to_a.join.scan(/XMAS/).count
  part_one += column.to_a.reverse.join.scan(/XMAS/).count
end
diagonals = diagonals(matrix)
diagonals.each do |diagonal|
  part_one += diagonal.join.scan(/XMAS/).count
  part_one += diagonal.reverse.join.scan(/XMAS/).count
end

p part_one

part_two = 0

matrix.row_vectors.each_with_index do |row, i|
  next if i < 1
  next if i >= matrix.row_count

  row.each_with_index do |char, j|
    next unless char == "A"

    positive = [matrix[i - 1, j - 1], char, matrix[i + 1, j + 1]].join
    negative = [matrix[i - 1, j + 1], char, matrix[i + 1, j - 1]].join
    positive_mas = %w[MAS SAM].include?(positive)
    negative_mas = %w[MAS SAM].include?(negative)

    next unless positive_mas && negative_mas

    part_two += 1
  end
end

p part_two
