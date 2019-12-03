# frozen_string_literal: true

# I originally had this map the coordinates in a different way
# fundamentally it is the same to me but it was coming up with the wrong answer
# needed to look at https://github.com/ni3t/advent-2019/blob/master/3_crossed_wires.rb
# to get on the right track
def coordinates(instructions_string)
  instructions = instructions_string.split(",")
  position = [0, 0]
  array = []
  instructions.each do |instruction|
    direction = instruction[0]
    distance = instruction.scan(/\d+/).first.to_i
    distance.times do
      if direction == "R"
        position[0] += 1
        array << position.clone
      elsif direction == "L"
        position[0] -= 1
        array << position.clone
      elsif direction == "U"
        position[1] += 1
        array << position.clone
      elsif direction == "D"
        position[1] -= 1
        array << position.clone
      end
    end
  end
  array
end

lines = INPUT.split("\n")
first_array = coordinates(lines.first)
second_array = coordinates(lines.last)
coord_intersections = first_array & second_array

part_one = coord_intersections.map do |intersection|
  intersection.map { |coord| coord.to_i.abs }.reduce(:+)
end.min

part_two = coord_intersections.map do |intersection|
  first_array.index(intersection) + 1 + second_array.index(intersection) + 1
end.min

puts part_one
puts part_two
