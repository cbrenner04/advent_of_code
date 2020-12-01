# frozen_string_literal: true

inputs = INPUT.split("").map(&:to_i)

base_pattern = [0, 1, 0, -1]
patterns = []
(inputs.count + 1).times do |i|
  skip_first = true
  local_pattern = []
  inputs.count.times do
    base_pattern.each_with_index do |pattern, index|
      timeses = index.zero? && skip_first ? i - 1 : i
      timeses.times { local_pattern << pattern }
    end
    skip_first = false
    foo = local_pattern.first(inputs.count)
    patterns << foo if local_pattern.count >= inputs.count && !patterns.include?(foo)
  end
end

100.times do
  next_inputs = []
  patterns.each do |pattern|
    local_inputs = []
    inputs.each_with_index do |input, input_index|
      local_inputs << input * pattern[input_index]
    end
    next_inputs << local_inputs.reduce(:+).abs % 10
  end
  inputs = next_inputs
end

puts inputs.first(8).join("")

# This take about 18 minutes to run. Since part two would be >10,000 times
# longer a different solution is required.
