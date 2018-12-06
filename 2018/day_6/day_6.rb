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
  "8, 9",
]

data = string_data.map { |coor| coor.scan(/\d+/).map(&:to_i) }

matrix = Array.new(10) { Array.new(10) }

data.each_with_index do |coor, index|
  coor.each { |c| matrix[coor[1]][coor[0]] = index }
end

p matrix
