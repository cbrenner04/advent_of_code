# frozen_string_literal: true
ROWS = 1000
COLUMNS = 1000

data = File.open("day_6_data.txt", "r") do |file|
  file.each_line.map do |line|
    line
      .chomp
      .gsub("turn on", "turn-on")
      .gsub("turn off", "turn-off")
      .split(" ")
  end
end

matrix = Array.new(ROWS) { Array.new(COLUMNS, 0) }

data.each do |datum|
  command = datum[0]
  start = datum[1].split(",")
  start_x = start[0].to_i
  start_y = start[1].to_i
  finish = datum[3].split(",")
  finish_x = finish[0].to_i
  finish_y = finish[1].to_i
  value = if command == "turn-on"
            1
          elsif command == "turn-off"
            -1
          elsif command == "toggle"
            2
          end
  (start_x..finish_x).each do |x_index|
    (start_y..finish_y).each do |y_index|
      matrix[x_index][y_index] += value
      matrix[x_index][y_index] = 0 if (matrix[x_index][y_index]).negative?
    end
  end
end

count = 0

matrix.each { |s| s.each { |a| count += a } }

p count
