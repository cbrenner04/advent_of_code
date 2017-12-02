# frozen_string_literal: true

data_file = File.join(File.dirname(__FILE__), "day_5_data.txt")
data = File.open(data_file).each_line.map(&:chomp)
count = 0

data.each do |datum|
  next if datum.include?("ab") || datum.include?("cd") ||
          datum.include?("pq") || datum.include?("xy")
  next unless datum.scan(/[aeoui]/).count >= 3
  repeated = false
  datum.each_char.with_index { |c, i| repeated = true if c == datum[i + 1] }
  next unless repeated == true
  count += 1
end

p count
