# frozen_string_literal: true

INPUT = "3,4,3,1,2"
fishes = INPUT.split(",").map(&:to_i)

# it doesn't just double every 7 days

# every 7 days, i need to know how many fish have greater than 6 days
# before spawning and remove that count before doubling

# i really don't want to brute force this but my maths is not good

# the brute force won't work on the second part

# part one - brute force
80.times do
  lfishes = fishes.dup
  lfishes.each_with_index do |fish, index|
    if fish.zero?
      fishes[index] = 6
      fishes.push(8)
    elsif fish.positive?
      fishes[index] -= 1
    else
      throw "HOW DID YOU GET HERE?"
    end
  end
end

p fishes.count

# TODO: need better solution
