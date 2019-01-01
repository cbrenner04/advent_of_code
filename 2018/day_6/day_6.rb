# frozen_string_literal: true

# manhattan distance of (p1, p2) and (q1, q2) is |p1 - q1| + |p2 - q2|
def manhattan(pt_1, pt_2)
  (pt_1[0] - pt_2[0]).abs + (pt_1[1] - pt_2[1]).abs
end

data_file = File.join(File.dirname(__FILE__), "day_6_data.txt")
string_data = File.open(data_file).each_line.map(&:chomp)

data = string_data.map { |coor| coor.scan(/\d+/).map(&:to_i) }

# Part One

x_max = data.map(&:first).max
y_max = data.map(&:last).max

matrix = Array.new(y_max + 1) { Array.new(x_max + 1, [nil, 0]) }

data.each_with_index do |coor, index|
  coor.each { matrix[coor[1]][coor[0]] = index }
end

data.each_with_index do |datum, datum_index|
  matrix.each_with_index do |row, row_index|
    row.each_with_index do |column, column_index|
      next unless column.is_a? Array
      distance = manhattan(datum, [column_index, row_index])
      if column[0].nil? || distance < column[1]
        matrix[row_index][column_index] = [datum_index, distance]
      elsif distance == column[1]
        matrix[row_index][column_index] = ["x", distance]
      end
    end
  end
end

infinite_indeces = []

matrix.first.each { |c| infinite_indeces << c.first if c.is_a? Array }
matrix.last.each { |c| infinite_indeces << c.first if c.is_a? Array }
matrix.each do |row|
  [row.first, row.last]
    .each { |c| infinite_indeces << c.first if c.is_a? Array }
end

infinite_indeces.uniq!
infinite_indeces.delete_if { |c| c == "x" }

not_infinite_indeces = []

matrix.each do |row|
  row.each do |column|
    next unless column.is_a? Array
    next if infinite_indeces.include? column.first
    next if column.first == "x"
    not_infinite_indeces << column.first
  end
end

areas = not_infinite_indeces.group_by { |e| e }.map { |k, v| [k, v.length + 1] }
largest = areas.max_by { |_k, v| v }

puts "Part 1: #{largest.last}"

# Part Two

matrix = Array.new(y_max + 1) { Array.new(x_max + 1, 0) }
data.each { |coor| coor.each { matrix[coor[1]][coor[0]] = "x" } }

matrix.each_with_index do |row, row_index|
  row.each_with_index do |column, column_index|
    sum = data.map do |datum|
      manhattan(datum, [column_index, row_index]) if column.is_a? Integer
    end.compact.reduce(:+)
    sum = nil if sum.nil? || sum >= 10_000
    matrix[row_index][column_index] = sum
  end
end

matrix.each_with_index do |row, row_index|
  row.each_with_index do |column, column_index|
    next if (column.nil? && column_index == x_max) ||
            (column.nil? && column_index.zero?) ||
            (column.nil? &&
              (row[column_index - 1].nil? || row[column_index + 1].nil?))
    matrix[row_index][column_index] = true
  end
end

puts "Part 2: #{matrix.flatten.compact.count}"
