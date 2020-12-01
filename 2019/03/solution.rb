# frozen_string_literal: true

# I originally had this map the coordinates by taking the current x (for R or L)
# or y (for U or D) and added 1 (R or U) or subtracted 1 (L or D) and added or
# substracted the distance. The min / max of these two numbers were used to set
# the start and finish of the range and the range was iterated over to set the
# coordinates in the array. For example, if the current x is 2 and the current y
# is 3 and the instruction is R100, then I would have a range of 3..102 for x
# and y would stay constant. Then [3, 3], [4, 3], [5, 3],...[102, 3] would be
# added to the array. The problem here is that when the numbers were negative
# (say -1 and -32), the range was `(-32..-1).each`. This put the coordinates in
# the array for that instruction backwards. This did not cause issues for part 1
# but did cause issues for part 2 as the indexes of those coordinates were
# effectively wrong. I needed to look at
# https://github.com/ni3t/advent-2019/blob/master/3_crossed_wires.rb to get on
# the right track.

def coordinates(instructions_string)
  instructions = instructions_string.split(",")
  position = [0, 0]
  array = []
  instructions.each do |instruction|
    direction = instruction[0]
    distance = instruction.scan(/\d+/).first.to_i
    distance.times do
      case direction
      when "R"
        position[0] += 1
        array << position.clone
      when "L"
        position[0] -= 1
        array << position.clone
      when "U"
        position[1] += 1
        array << position.clone
      when "D"
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
