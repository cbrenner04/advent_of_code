# frozen_string_literal: true

data_file = File.join(File.dirname(__FILE__), "day_2_data.txt")
data = File.open(data_file).each_line.map do |line|
  line.chomp.split("x").map(&:to_i).sort
end

square_feets = []
lengths = []

data.each do |d|
  square_feets.push(
    (2 * d[0] * d[1]) + (2 * d[1] * d[2]) + (2 * d[0] * d[2]) + (d[0] * d[1])
  )
  lengths.push((2 * d[0]) + (2 * d[1]) + (d[0] * d[1] * d[2]))
end

p square_feets.reduce(&:+)
p lengths.reduce(&:+)
