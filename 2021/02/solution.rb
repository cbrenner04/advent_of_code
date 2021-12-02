# frozen_string_literal: true

# TODO: this is brute force and lame. while it works for this input, it may not
# with something more complex. There has got to be a better way. Time is tight
# atm so leaving for now.

p1_coor = [0, 0]
p2_coor = [0, 0]
aim = 0
INPUT.each_line do |line|
  direction, amount = line.split

  case direction
  when "forward"
    p1_coor[0] += amount.to_i
    p2_coor[0] += amount.to_i
    p2_coor[1] += amount.to_i * aim
  when "down"
    p1_coor[1] += amount.to_i
    aim += amount.to_i
  when "up"
    p1_coor[1] -= amount.to_i
    aim -= amount.to_i
  else
    throw "HOW DID YOU GET HERE?"
  end
end

puts p1_coor.reduce(:*)
puts p2_coor.reduce(:*)
