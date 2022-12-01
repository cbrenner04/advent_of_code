# frozen_string_literal: true

data = INPUT.each_line.map(&:to_i)

shit = []
sum = 0
data.each do |d|
  if d.zero?
    shit.push(sum)
    sum = 0
  else
    sum += d
  end
end

# part 1
p shit.max

sorted = shit.sort
# part 2
p sorted[-3] + sorted[-2] + sorted[-1]
