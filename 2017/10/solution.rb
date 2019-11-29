# frozen_string_literal: true

# based on https://www.reddit.com/r/adventofcode/comments/7irzg5/2017_day_10_solutions/dr10wbf/

# rubocop:disable Metrics/MethodLength
def twist(lengths, iterations)
  pos = 0
  skip_size = 0
  list = (0..255).to_a

  iterations.times do
    lengths.each do |len|
      list.rotate!(pos)
      list[0, len] = list[0, len].reverse
      list.rotate!(-pos)
      pos += len + skip_size
      skip_size += 1
    end
  end
  list
end
# rubocop:enable Metrics/MethodLength

input = [199, 0, 255, 136, 174, 254, 227, 16, 51, 85, 1, 2, 22, 17, 7, 192]

twisted = twist(input, 1)
first_two = twisted.take(2)
puts first_two.reduce(:*)

input = input.join(",")

twisted = twist(input.bytes + [17, 31, 73, 47, 23], 64)
hashed = twisted.each_slice(16).map do |byte|
  xord = byte.reduce(0, :^) # perform xor
  hash = xord.to_s(16) # convert to hex
  hash.rjust(2, "0") # pad with leading zeros if needed
end
puts hashed.join
