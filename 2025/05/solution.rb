# frozen_string_literal: true

# INPUT = "3-5
# 10-14
# 16-20
# 12-18

# 1
# 5
# 8
# 11
# 17
# 32"

ranges, ids = INPUT.split("\n\n").map { |group| group.each_line.map(&:chomp) }
ranges = ranges.map { |r| r.split("-").map(&:to_i) }
ids = ids.map(&:to_i)
count = 0

ids.each do |id|
  count += 1 if ranges.any? { |low, high| id >= low && id <= high }
end

p count
foo = ranges.map { |low, high| (low..high).to_a }
p foo.flatten.uniq.count # doesn't work for full input. runs out of memory. practice input is correct
