# frozen_string_literal: true

# INPUT = "123"

# INPUT = "1
# 10
# 100
# 2024"

def mix(a, b)
  a ^ b
end

def prune(a)
  a % 16_777_216
end

# def ones(a)
#   a.to_s.split("").last.to_i
# end

numbers = INPUT.each_line.map(&:to_i)
# all_sequences = []
# all_bananas = []
part_one = numbers.map do |number|
  current = number
  # current_ones = ones(current)
  # all_changes = []
  # sequences = []
  # bananas = []
  2000.times do
    times_64 = current * 64
    first_mixed = mix(times_64, current)
    first_pruned = prune(first_mixed)
    divide_32 = first_pruned / 32
    second_mixed = mix(divide_32, first_pruned)
    second_pruned = prune(second_mixed)
    multiply_2048 = second_pruned * 2048
    third_mixed = mix(multiply_2048, second_pruned)
    third_pruned = prune(third_mixed)
    current = third_pruned
    # previous_ones = current_ones
    # current_ones = ones(third_pruned)
    # change = current_ones - previous_ones
    # all_changes << change
    # sequences << all_changes[all_changes.count - 4..]
    # bananas << current_ones
  end
  # all_sequences << sequences
  # all_bananas << bananas
  current
end

p part_one.reduce(:+)
# all_sequences.each_with_index do |sequences, i|
#   s_i = sequences.index([-2, 1, -1, 3])
#   next unless s_i

#   p all_bananas[i][s_i]
# end
