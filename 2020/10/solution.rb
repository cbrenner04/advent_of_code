# frozen_string_literal: true

data = INPUT.each_line.map { |l| l.chomp.to_i }.sort.unshift(0)
data.push(data.last + 3)

diff_1 = 0
diff_3 = 0

# after inspecting the data, onty differences of 1 and 3 exist
data.each_with_index do |datum, index|
  break if index == data.length - 1

  diff = data[index + 1] - datum
  diff_1 += 1 if diff == 1
  diff_3 += 1 if diff == 3
end

p diff_1 * diff_3
