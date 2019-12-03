# frozen_string_literal: true

require "set"

def coordinates(instructions_string)
  instructions = instructions_string.split(",")
  current_x = 0
  current_y = 0
  array = []
  instructions.each do |instruction|
    direction = instruction[0]
    distance = instruction.scan(/\d+/).first.to_i
    if direction == "R"
      (current_x + 1..current_x + distance).each do |x|
        array << "#{x},#{current_y}"
      end
      current_x += distance
    elsif direction == "L"
      (current_x - distance..current_x - 1).each do |x|
        array << "#{x},#{current_y}"
      end
      current_x -= distance
    elsif direction == "U"
      (current_y + 1..current_y + distance).each do |y|
        array << "#{current_x},#{y}"
      end
      current_y += distance
    elsif direction == "D"
      (current_y - distance..current_y - 1).each do |y|
        array << "#{current_x},#{y}"
      end
      current_y -= distance
    end
  end
  array
end

# INPUT = "R75,D30,R83,U83,L12,D49,R71,U7,L72\nU62,R66,U55,R34,D71,R55,D58,R83"
# INPUT = "R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51\n" \
#         "U98,R91,D20,R16,D67,R40,U7,R15,U6,R7"

lines = INPUT.split("\n")
first_array = coordinates(lines.first)
second_array = coordinates(lines.last)
# convert to set to use `intersection`
coord_intersections = first_array.to_set.intersection(second_array.to_set)

minimum = coord_intersections.map do |intersection|
  intersection.split(",").map { |coord| coord.to_i.abs }.reduce(:+)
end.min

puts minimum

part_two_minimum = coord_intersections.map do |intersection|
  first_array.index(intersection) + 1 + second_array.index(intersection) + 1
end.min

# example 1: correct - 610
# example 2: wrong - 416 (high)
# real: wrong - 14148 (low)

p part_two_minimum
