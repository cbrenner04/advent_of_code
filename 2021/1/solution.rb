# frozen_string_literal: true

def count_larger(data)
  data.each_with_index.map { |datum, index| index.positive? && datum > data[index - 1] ? 1 : 0 }.reduce(:+)
end

data = INPUT.each_line.map(&:to_i)

puts count_larger(data)

part_2 = data.each_with_index.map do |datum, index|
  next unless data[index + 1] && data[index + 2]

  datum + data[index + 1] + data[index + 2]
end.compact

puts count_larger(part_2)
