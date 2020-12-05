# frozen_string_literal: true

ROWS = 1000
COLUMNS = 1000

def split_it(datum)
  command = datum[0]
  start = datum[1].split(",")
  start_x = start[0].to_i
  start_y = start[1].to_i
  finish = datum[3].split(",")
  finish_x = finish[0].to_i
  finish_y = finish[1].to_i
  [command, start_x, start_y, finish_x, finish_y]
end

data = INPUT.each_line.map do |line|
  line
    .chomp
    .gsub("turn on", "turn-on")
    .gsub("turn off", "turn-off")
    .split(" ")
end

first_matrix = Array.new(ROWS) { Array.new(COLUMNS, false) }

data.each do |datum|
  command, start_x, start_y, finish_x, finish_y = split_it(datum)
  if %w[turn-on turn-off].include?(command)
    value = command == "turn-on"
    (start_x..finish_x).each do |x_index|
      (start_y..finish_y).each do |y_index|
        first_matrix[x_index][y_index] = value
      end
    end
  elsif command == "toggle"
    (start_x..finish_x).each do |x_index|
      (start_y..finish_y).each do |y_index|
        first_matrix[x_index][y_index] = first_matrix[x_index][y_index] == false
      end
    end
  end
end

part_one_count = 0

first_matrix.each { |s| s.each { |a| part_one_count += 1 if a } }

p part_one_count

second_matrix = Array.new(ROWS) { Array.new(COLUMNS, 0) }

data.each do |datum|
  command, start_x, start_y, finish_x, finish_y = split_it(datum)
  value = { "turn-on" => 1, "turn-off" => -1, "toggle" => 2 }[command]
  (start_x..finish_x).each do |x_index|
    (start_y..finish_y).each do |y_index|
      second_matrix[x_index][y_index] += value
      second_matrix[x_index][y_index] = 0 if (second_matrix[x_index][y_index]).negative?
    end
  end
end

part_two_count = 0

second_matrix.each { |s| s.each { |a| part_two_count += a } }

p part_two_count
