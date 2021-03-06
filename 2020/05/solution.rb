# frozen_string_literal: true

data = INPUT.each_line.map(&:chomp)

# binary solution (only got to this after seeing others)
ids = data.map { |d| d.gsub(/[BFRL]/, "B" => "1", "F" => "0", "L" => "0", "R" => "1").to_i(2) }.sort
# # binary solution before realizing you can do away with the column * 8 + row, also go fancier with my text replacement
# ids = data.map { |d| d.tr("B", "1").tr("F", "0").to_i(2) * 8 + d[7..-1].tr("R", "1").tr("L", "0").to_i(2) }.sort

p ids.last
p ((ids.first..ids.last).to_a - ids).first

# # original naive solution
# require_relative("./util")

# ids = data.map do |datum|
#   rows = datum[0..6].split("")
#   columns = datum[7..-1].split("")

#   row = find_row(rows)
#   column = find_column(columns)

#   (row * 8 + column)
# end.sort

# p ids.last
# p ((ids.first..ids.last).to_a - ids).first
