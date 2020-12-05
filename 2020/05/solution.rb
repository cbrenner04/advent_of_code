# frozen_string_literal: true

require_relative("./util")

data = INPUT.each_line.map(&:chomp)
highest_id = 0
ids = []

data.each do |i|
  rows = i[0..6].split("")
  columns = i[7..-1].split("")

  row = find_row(rows)
  column = find_column(columns)

  id = row * 8 + column

  # part one
  highest_id = highest_id < id ? id : highest_id

  # part two
  ids.push(id)
end

p highest_id

ids.sort!
p ((ids.first..ids.last).to_a - ids).first
