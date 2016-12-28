# frozen_string_literal: true

def solve(data, part_two)
  count = 0
  position = 1

  data.each_char do |d|
    d == "(" ? count += 1 : count -= 1

    break if count == -1 && part_two == true
    position += 1
  end

  p count if part_two == false
  p position if part_two == true
end

data = File.read("day_1_data.txt")[0..-2]
solve(data, false)
solve(data, true)
