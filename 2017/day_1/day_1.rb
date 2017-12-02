# frozen_string_literal: true

data_file = File.join(File.dirname(__FILE__), "day_1_data.txt")
data = File.read(data_file).chomp.split("").map(&:to_i)

part_one_matches = data.each_with_index.map do |x, i|
  x if (i == data.length - 1 && x == data[0]) || x == data[i + 1]
end.compact

part_two_matches =  data.each_with_index.map do |x, i|
  matcher_index = i + (data.length / 2)
  matcher_index -= data.length if matcher_index >= data.length
  x if x == data[matcher_index]
end.compact

p part_one_matches.reduce(&:+)
p part_two_matches.reduce(&:+)
