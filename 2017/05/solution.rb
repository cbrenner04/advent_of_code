# frozen_string_literal: true

data = INPUT.each_line.map { |line| line.chomp.to_i }
count = 1
next_index = 0 + data[0]
data[0] += 1

until next_index > data.length - 1
  current_data = data[next_index]
  current_index = next_index
  data[current_index] += 1
  next_index = current_index + current_data
  count += 1
end

p count

data = INPUT.each_line.map { |line| line.chomp.to_i }
count = 1
next_index = 0 + data[0]
data[0] += 1

until next_index > data.length - 1
  current_data = data[next_index]
  current_index = next_index
  data[current_index] += current_data >= 3 ? -1 : 1
  next_index = current_index + current_data
  count += 1
end

p count
