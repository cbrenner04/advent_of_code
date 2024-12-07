# frozen_string_literal: true

# INPUT = "190: 10 19
# 3267: 81 40 27
# 83: 17 5
# 156: 15 6
# 7290: 6 8 6 15
# 161011: 16 10 13
# 192: 17 8 14
# 21037: 9 7 18 13
# 292: 11 6 16 20"

# slow
part_one = 0
INPUT.each_line(chomp: true) do |equation|
  split = equation.split(": ")
  value = split.first.to_i
  numbers = split.last.split.map(&:to_i)
  ["+", "*"].repeated_permutation(numbers.count - 1).each do |operators|
    combination = numbers.zip(operators).flatten.compact
    current_value = combination.first
    start = 0
    until start >= combination.count - 2
      eq = [current_value].concat(combination.slice(start + 1, 2)).join
      current_value = eval(eq)
      start += 2
    end

    break part_one += value if current_value == value
  end
end

p part_one

# so slow
part_two = 0
INPUT.each_line(chomp: true) do |equation|
  split = equation.split(": ")
  value = split.first.to_i
  numbers = split.last.split.map(&:to_i)
  ["+", "*", "||"].repeated_permutation(numbers.count - 1).each do |operators|
    combination = numbers.zip(operators).flatten.compact
    current_value = combination.first
    start = 0
    until start >= combination.count - 2
      if combination[start + 1] == "||"
        current_value = (current_value.to_s << combination[start + 2].to_s).to_i
      else
        eq = [current_value].concat(combination.slice(start + 1, 2)).join
        current_value = eval(eq)
      end
      start += 2
    end

    break part_two += value if current_value == value
  end
end

p part_two
