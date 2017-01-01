# frozen_string_literal: true
data = File.open("day_8_data.txt", "r") { |f| f.each_line.map { |l| l[1..-3] } }
original_lengths = data.map(&:length)
original_total = original_lengths.reduce(&:+)
not_escaped = data.map(&:dump)
not_escaped_lengths = not_escaped.map(&:length)
not_escaped_total = not_escaped_lengths.reduce(&:+)
p not_escaped
p not_escaped_lengths
p not_escaped_total
p data
p original_lengths
p original_total
p not_escaped_total - original_total
