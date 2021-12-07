# frozen_string_literal: true

crab_positions = INPUT.split(",").map(&:to_i)
largest_position = crab_positions.max
total_fuels = []
(0..largest_position).each do |position|
  total_fuels.push(crab_positions.map { |crab| (crab - position).abs }.reduce(:+))
end

p total_fuels.min

# we'll see if this completes in any reasonable amount of time
# as you may have guessed, it does not
# but it isn't so long that i needed to rewrite
total_fuels = []
(0..largest_position).each do |position|
  total_fuels.push(crab_positions.map do |crab|
    (0..(crab - position).abs).to_a.map { |c| c }.reduce(:+)
  end.reduce(:+))
end

p total_fuels.min
