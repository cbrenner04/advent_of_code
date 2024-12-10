# frozen_string_literal: true

require "matrix"
# for `diagonal`
require_relative "../../util"

# INPUT = "............
# ........0...
# .....0......
# .......0....
# ....0.......
# ......A.....
# ............
# ............
# ........A...
# .........A..
# ............
# ............"

splitted = INPUT.each_line(chomp: true).map { |line| line.split("") }
matrix = Matrix.rows(splitted)

rows = matrix.row_vectors.map(&:to_a)
columns = matrix.column_vectors.map(&:to_a)
diags = []

(1..matrix.row_count).each do |i|
  (1..matrix.column_count).each do |j|
    diags << diagonals(matrix, { row_step: i, column_step: j })
  end
end

def check_vector(vector)
  count = 0
  max_index = vector.count - 1
  match = vector.join.scan(/\w{2}/)

  match.each do |m|
    next unless m && m[0] == m[1]

    indexes = vector.each_index.select { |i| vector[i] == m[0] }
    count += 1 if (indexes.first - 1) >= 0
    count += 1 if (indexes.last + 1) <= max_index
  end
  count
end

count = 0
rows.concat(columns).each do |vector|
  next if vector.count < 3

  count += check_vector(vector)
end

diags.each do |diag|
  diag.each do |d|
    next if d.count < 3

    count += check_vector(d)
  end
end

p count
