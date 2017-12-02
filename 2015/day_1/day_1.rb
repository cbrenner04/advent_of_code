# frozen_string_literal: true

def solve(data, part_two)
  count = 0
  position = 1

  data.each_char do |d|
    count += d == "(" ? 1 : -1
    break if count.negative? && part_two
    position += 1
  end

  p part_two ? position : count
end

data_file = File.join(File.dirname(__FILE__), "day_1_data.txt")
data = File.read(data_file).chomp
solve(data, false)
solve(data, true)
