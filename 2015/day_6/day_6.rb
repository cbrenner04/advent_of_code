# frozen_string_literal: true

ROWS = 1000
COLUMNS = 1000

data_file = File.join(File.dirname(__FILE__), "day_6_data.txt")
data = File.open(data_file).each_line.map do |line|
  line
    .chomp
    .gsub("turn on", "turn-on")
    .gsub("turn off", "turn-off")
    .split(" ")
end

matrix = Array.new(ROWS) { Array.new(COLUMNS, false) }

data.each do |datum|
  command = datum[0]
  start = datum[1].split(",")
  start_x = start[0].to_i
  start_y = start[1].to_i
  finish = datum[3].split(",")
  finish_x = finish[0].to_i
  finish_y = finish[1].to_i
  if %w[turn-on turn-off].include?(command)
    value = command == "turn-on"
    (start_x..finish_x).each do |x_index|
      (start_y..finish_y).each do |y_index|
        matrix[x_index][y_index] = value
      end
    end
  elsif command == "toggle"
    (start_x..finish_x).each do |x_index|
      (start_y..finish_y).each do |y_index|
        matrix[x_index][y_index] = matrix[x_index][y_index] == false
      end
    end
  end
end

count = 0

matrix.each { |s| s.each { |a| count += 1 if a } }

p count
