# frozen_string_literal: true

data = INPUT.split("\n\n").map(&:split)

counts = data.map do |group|
  answers = group.flat_map(&:chars).uniq
  all_count = answers.map { |a| group.all? { |g| g.include?(a) } ? 1 : 0 }.reduce(:+)
  [answers.count, all_count]
end

p counts.map(&:first).reduce(:+)
p counts.map(&:last).reduce(:+)
