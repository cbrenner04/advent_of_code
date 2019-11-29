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

solve(INPUT, false)
solve(INPUT, true)
