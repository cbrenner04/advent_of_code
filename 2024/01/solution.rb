# frozen_string_literal: true

# INPUT = "3   4
# 4   3
# 2   5
# 1   3
# 3   9
# 3   3"

inputs = INPUT.each_line.map(&:split).transpose.map { |a| a.map(&:to_i).sort }

part_one = inputs.first.zip(inputs.last).map do |a, b|
  b > a ? b - a : a - b
end.reduce(:+)

p part_one

part_two = inputs.first.map do |num|
  inputs.last.find_all { |i| i == num }.count * num
end.reduce(:+)

p part_two
