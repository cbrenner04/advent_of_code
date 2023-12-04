# frozen_string_literal: true

require_relative "../../util"

# INPUT = "R 4
# U 4
# L 3
# D 1
# R 4
# D 1
# L 5
# R 2"

data = INPUT.each_line.map do |d|
  a, b = d.chomp.split(/\s/)
  [a, b.to_i]
end
rows = { R: 0, L: 0 }
columns = { U: 0, D: 0 }

data.each do |direction, amount|
  if %w[R L].include?(direction)
    current = rows[direction.to_sym].dup
    rows[direction.to_sym] = [amount, current].max
  else
    current = columns[direction.to_sym].dup
    columns[direction.to_sym] = [amount, current].max
  end
end

row_size = rows.values.reduce(:+)
column_size = columns.values.reduce(:+)
matrix = simple_matrix(row_size, column_size)
# starting point
current_x = 0 # columns
current_y = row_size - 1 # rows
matrix[current_y][current_x] = true
# TODO: this works for head; still need to handle the difference in tail
data.each do |direction, amount|
  prev_x = current_x.dup
  prev_y = current_y.dup
  case direction
  when "R"
    current_x += amount
    (prev_x..current_x).each { |x| matrix[current_y][x] = true }
  when "L"
    current_x -= amount
    (current_x..prev_x).each { |x| matrix[current_y][x] = true }
  when "U"
    current_y -= amount
    (current_y..prev_y).each { |y| matrix[y][current_x] = true }
  when "D"
    current_y += amount
    (prev_y..current_y).each { |y| matrix[y][current_x] = true }
  else
    throw "You're an idiot. This is not a direction"
  end
end

matrix.each { |row| p row.map { |r| r ? "#" : "." }.join }
