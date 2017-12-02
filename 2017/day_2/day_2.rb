# frozen_string_literal: true

data_file = File.join(File.dirname(__FILE__), "day_2_data.txt")
data = File.open(data_file).each_line.map do |line|
  line.chomp.split(" ").map(&:to_i).sort
end
products = []

diffs = data.map { |line| line.last - line.first }

data.each do |line|
  sorted = line.reverse
  sorted.each_with_index do |x, index|
    i = index + 1
    until i >= sorted.length
      products.push(x / sorted[i]) if (x % sorted[i]).zero?
      i += 1
    end
  end
end

p diffs.reduce(&:+)
p products.reduce(&:+)
