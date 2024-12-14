# frozen_string_literal: true

# INPUT = "125 17"

def handle_rock_manipulation(rock)
  rock_string = rock.to_s
  rock_length = rock_string.length

  if rock.zero?
    1
  elsif rock_length.even?
    half_length = rock_length / 2
    [rock_string[0, half_length].to_i, rock_string[half_length, half_length].to_i]
  else
    rock * 2024
  end
end

rocks = INPUT.chomp.split.map(&:to_i)

25.times { rocks = rocks.map { |rock| handle_rock_manipulation(rock) }.flatten }

p rocks.count

# this will never finish in my lifetime
50.times { rocks = rocks.map { |rock| handle_rock_manipulation(rock) }.flatten }

p rocks.count
