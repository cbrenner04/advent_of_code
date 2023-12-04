# frozen_string_literal: true

# needed help. stolen from: https://www.reddit.com/r/adventofcode/comments/7iksqc/2017_day_9_solutions/dqzm28k/

part_one = INPUT.dup
part_two = INPUT.dup

part_one.gsub!(/!./, "")
part_one.gsub!(/<.*?>/, "")
score = 0
total = 0
part_one.chars.each do |char|
  score += 1 if char == "{"
  if char == "}"
    total += score
    score -= 1
  end
end
puts "Part 1: #{total}"

part_two.gsub!(/!./, "")
count = part_two.scan(/<.*?>/).map { |str| str.length - 2 }.reduce(0, :+)
puts "Part 2: #{count}"
