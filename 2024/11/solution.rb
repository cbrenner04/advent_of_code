# frozen_string_literal: true

# INPUT = "125 17"

def handle_rock_manipulation(rock)
  if rock.zero?
    1
  elsif rock.to_s.length.even?
    rock.to_s.chars.each_slice(rock.to_s.length / 2).map(&:join).map(&:to_i)
  else
    rock * 2024
  end
end

rocks = INPUT.chomp.split(" ").map(&:to_i)
part_one = rocks.clone
part_two = rocks.clone

25.times { part_one = part_one.map { |rock| handle_rock_manipulation(rock) }.flatten }

p part_one.count

75.times { part_two = part_two.map { |rock| handle_rock_manipulation(rock) }.flatten }

p part_two.count
