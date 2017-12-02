# frozen_string_literal: true

def sum(arry)
  arry.inject(0) { |sum, x| sum + x }
end

data = File.open("day_1_data.txt").each_char.reject { |c| c == "\n" }
part_one_matches = []
part_two_matches = []

data.each_with_index do |d, i|
  next unless (i == data.count - 1 && d == data[0]) || d == data[i + 1]
  part_one_matches << d.to_i
end

data.each_with_index do |d, i|
  matcher_index = i + (data.count / 2)
  matcher_index -= data.count if matcher_index >= data.count
  next unless d == data[matcher_index]
  part_two_matches << d.to_i
end

p sum(part_one_matches)
p sum(part_two_matches)
