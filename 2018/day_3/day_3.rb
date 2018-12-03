# frozen_string_literal: true

data_file = File.join(File.dirname(__FILE__), "day_3_data.txt")
data = File.open(data_file).each_line.map(&:chomp)

# # example
# data = [
#   "#1 @ 1,3: 4x4",
#   "#2 @ 3,1: 4x4",
#   "#3 @ 5,5: 2x2",
# ]

greatest_x = 0
greatest_y = 0

range_info = data.map do |datum|
  arry = datum.split(" ")

  starting_points = arry[2].delete(":").split(",")
  x_starting_point = starting_points[1].to_i + 1
  y_starting_point = starting_points[0].to_i + 1

  sizes = arry[3].split("x")
  x_ending_point = x_starting_point + sizes[1].to_i - 1
  y_ending_point = y_starting_point + sizes[0].to_i - 1

  greatest_x = x_ending_point if x_ending_point > greatest_x
  greatest_y = y_ending_point if y_ending_point > greatest_y

  [[x_starting_point, x_ending_point], [y_starting_point, y_ending_point], arry[0]]
end

matrix = Array.new(greatest_x + 1) { Array.new(greatest_y + 1, 0) }

non_overlapping_ids = []

range_info.each do |info|
  overlap_occurred = false
  x_range = info[0]
  y_range = info[1]

  (x_range.first..x_range.last).each do |x_coor|
    (y_range.first..y_range.last).each do |y_coor|
      overlap_occurred = true if matrix[x_coor - 1][y_coor - 1] > 0
      matrix[x_coor - 1][y_coor - 1] += 1
    end
  end

  non_overlapping_ids.push(info[2]) unless overlap_occurred
end

non_overlapping_id = nil

# need to go through list of non_overlapping_ids again as they may have been
# overlapped by a subsequent claim
range_info.each do |info|
  id = info[2]

  next unless non_overlapping_ids.include?(id)

  overlap_occurred = false
  x_range = info[0]
  y_range = info[1]

  (x_range.first..x_range.last).each do |x_coor|
    break unless (y_range.first..y_range.last).each do |y_coor|
      if matrix[x_coor - 1][y_coor - 1] > 1
        overlap_occurred = true
        break
      end
    end
  end

  non_overlapping_id = id unless overlap_occurred
end

count_overlap = 0

matrix.each do |rows|
  rows.each do |cell|
    count_overlap += 1 if cell > 1
  end
end

puts "Part one: #{count_overlap}"
puts "Part two: #{non_overlapping_id}"
