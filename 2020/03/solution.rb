# frozen_string_literal: true

DATA = INPUT.each_line.map { |l| l.chomp.chars }
TOTAL_ROWS = DATA.count

def find_trees(index_change, row_change)
  index = 0
  row = 0
  trees = 0

  until row == TOTAL_ROWS - 1
    row += row_change
    index += index_change
    index -= DATA[row].count if index > DATA[row].count - 1

    trees += 1 if DATA[row][index] == "#"
  end

  trees
end

puts find_trees(3, 1)
puts [[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]].map { |x, y| find_trees(x, y) }.reduce(:*)
