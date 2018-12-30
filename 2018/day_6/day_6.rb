# frozen_string_literal: true

# NOT CURRENTLY WORKING

# manhattan distance of (p1, p2) and (q1, q2) is |p1 - q1| + |p2 - q2|

# data_file = File.join(File.dirname(__FILE__), "day_4_data.txt")
# string_data = File.open(data_file).each_line.map(&:chomp)

# example
string_data = [
  "1, 1",
  "1, 6",
  "8, 3",
  "3, 4",
  "5, 5",
  "8, 9"
]

data = string_data.map { |coor| coor.scan(/\d+/).map(&:to_i) }

matrix = Array.new(10) { Array.new(10, [nil, 0]) }

data.each_with_index do |coor, index|
  coor.each { matrix[coor[1]][coor[0]] = index }
end

data.each_with_index do |datum, datum_index|
  matrix.each_with_index do |rows, row_index|
    rows.each_with_index do |point, point_index|
      next unless point.is_a?(Array)
      manhattan_dist = (datum[0] - point_index).abs + (datum[1] - row_index).abs
      if manhattan_dist < point[1] || point[0].nil?
        point[0] = datum_index
        point[1] = manhattan_dist
      elsif manhattan_dist == point[1]
        point[0] = "x"
      end
    end
  end
end

matrix.each { |m| p m }
