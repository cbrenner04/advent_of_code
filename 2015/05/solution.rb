# frozen_string_literal: true

data = INPUT.each_line.map(&:chomp)
part_1_count = 0

data.each do |datum|
  next if datum.include?("ab") || datum.include?("cd") ||
          datum.include?("pq") || datum.include?("xy")
  next unless datum.scan(/[aeoui]/).count >= 3

  repeated = false
  datum.each_char.with_index { |c, i| repeated = true if c == datum[i + 1] }
  next unless repeated == true

  part_1_count += 1
end

part_2_count = 0

data.each do |datum|
  repeated = false
  last_index = datum.length - 1
  (0..last_index).each do |i|
    sub = datum[i..i + 1]
    (i + 2..last_index).each { |j| repeated = true if sub == datum[j..j + 1] }
  end
  next unless repeated == true

  repeated = false
  datum.each_char.with_index { |c, i| repeated = true if c == datum[i + 2] }
  next unless repeated == true

  part_2_count += 1
end

p part_1_count
p part_2_count
