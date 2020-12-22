# frozen_string_literal: true

data = INPUT.split(",").map(&:to_i)

copy = data.dup
number_spoken = ""
starting_length = copy.length

# this returns reasonably quickly for part one (2020 steps), not so for part 2 (30_000_000 steps)
(2020 - starting_length).times do |i|
  current_turn = i + starting_length
  last_spoken = copy.pop
  previous_turn = copy.rindex(last_spoken)
  copy << last_spoken
  number_spoken = previous_turn.nil? ? 0 : (current_turn - previous_turn - 1)
  copy << number_spoken
end

puts number_spoken
