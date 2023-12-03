# frozen_string_literal: true

# INPUT = "    [D]
# [N] [C]
# [Z] [M] [P]
#  1   2   3

# move 1 from 2 to 1
# move 3 from 1 to 3
# move 2 from 2 to 1
# move 1 from 1 to 2"

data = INPUT.each_line.map(&:chomp)
arrangement = []

data.dup.each do |line|
  break if line.empty?

  arrangement << data.shift
end
data.shift # handles blank line between pieces
number_of_stacks = arrangement.pop.strip.split.last.to_i
levels = arrangement.map do |level|
  l = level.split("").each_slice(4).map { |cargo| cargo.join.strip }
  l.count < number_of_stacks ? l << "" : l
end
stacks = (0...number_of_stacks).map do |stack_number|
  levels.map { |l| l[stack_number] }.reverse.reject(&:empty?)
end
# deep clone for later
p_1_stacks = Marshal.load(Marshal.dump(stacks))
p_2_stacks = Marshal.load(Marshal.dump(stacks))

# p1 specific
data.each do |direction|
  amount, from, to = direction.scan(/\d+/).map(&:to_i)
  amount.times do |_i|
    element = p_1_stacks[from - 1].pop
    p_1_stacks[to - 1].push(element)
  end
end

p_1 = p_1_stacks.map(&:last).join.delete("[").delete("]")
puts p_1

# p2 specific
data.each do |direction|
  amount, from, to = direction.scan(/\d+/).map(&:to_i)
  elements = p_2_stacks[from - 1].pop(amount)
  p_2_stacks[to - 1].push(*elements)
end

p_2 = p_2_stacks.map(&:last).join.delete("[").delete("]")
puts p_2
