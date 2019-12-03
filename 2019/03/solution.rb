# frozen_string_literal: true

require "set"

# map all x,y coordinates
# use Set cuz that has `intersection`
# since putting it into a set need to use reduce

def coordinates(instructions_string)
  instructions = instructions_string.split(",")
  current_x = 0
  current_y = 0
  instructions.each_with_object(Set.new) do |instruction, memo|
    direction = instruction[0]
    distance = instruction.scan(/\d+/).first.to_i
    if direction == "R"
      (current_x + 1..current_x + distance).each do |x|
        memo << "#{x},#{current_y}"
      end
      current_x += distance
    elsif direction == "L"
      (current_x - distance..current_x - 1).each do |x|
        memo << "#{x},#{current_y}"
      end
      current_x -= distance
    elsif direction == "U"
      (current_y + 1..current_y + distance).each do |y|
        memo << "#{current_x},#{y}"
      end
      current_y += distance
    elsif direction == "D"
      (current_y - distance..current_y - 1).each do |y|
        memo << "#{current_x},#{y}"
      end
      current_y -= distance
    end
    memo
  end
end

# INPUT = "R75,D30,R83,U83,L12,D49,R71,U7,L72\nU62,R66,U55,R34,D71,R55,D58,R83"
# INPUT = "R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51\n" \
#         "U98,R91,D20,R16,D67,R40,U7,R15,U6,R7"

lines = INPUT.split("\n")
first = coordinates(lines.first)
second = coordinates(lines.last)
coord_intersections = first.intersection(second)

minimum = coord_intersections.map do |intersection|
  coords = intersection.split(",")
  ints = coords.map { |i| i.to_i.abs }
  ints.reduce(:+)
end.min

puts minimum

totals = []

first.each_with_index do |first_coord, first_index|
  next unless coord_intersections.include?(first_coord)
  second.each_with_index do |second_coord, second_index|
    next unless coord_intersections.include?(second_coord)
    totals << first_index + 1 + second_index + 1 if first_coord == second_coord
  end
end

# example 1: correct - 610
# example 2: wrong - 416 (high)
# real: wrong - 14142 (low)

puts totals.min
