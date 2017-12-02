# frozen_string_literal: true

data_file = File.join(File.dirname(__FILE__), "day_8_data.txt")
data = File.open(data_file).each_line.map { |line| line[1..-3] }
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
