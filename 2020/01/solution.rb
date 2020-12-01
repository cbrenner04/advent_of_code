# frozen_string_literal: true

data = INPUT.each_line.map(&:to_i)

puts data.combination(2).find { |x, y| x + y == 2020 }.reduce(:*)
puts data.combination(3).find { |x, y, z| x + y + z == 2020 }.reduce(:*)
