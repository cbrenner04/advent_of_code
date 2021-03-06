# frozen_string_literal: true

require_relative "../../util"

data = INPUT.each_line.map { |l| l.chomp.to_i }

index = 25
invalid = 0

loop do
  throw "Got through the list dummy" if index >= data.length

  current_number = data[index]
  comparison_set = data[(index - 25)..(index - 1)]
  sums = comparison_set.combination(2).map { |x, y| x + y }

  if sums.include?(current_number)
    index += 1
    next
  end

  invalid = current_number
  break
end

p invalid

subsequences = array_subsequences(data)

subsequences.each do |subs|
  sum = subs.reduce(:+)

  next unless sum == invalid

  p subs.min + subs.max
  break
end
