# frozen_string_literal: true
data = File.open("day_5_data.txt", "r") { |f| f.each_line.map { |l| l[0..-2] } }
count = 0

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
  count += 1
end

p count
