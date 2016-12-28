# frozen_string_literal: true
data = []
File.open("day_2_data.txt", "r") do |file|
  file.each_line { |line| data.push line[0..-2].split("x") }
end

square_feets = []
lengths = []

data.each do |d|
  d.map!(&:to_i).sort!
  square_feets.push(
    (2 * d[0] * d[1]) + (2 * d[1] * d[2]) + (2 * d[0] * d[2]) + (d[0] * d[1])
  )
  lengths.push((2 * d[0]) + (2 * d[1]) + (d[0] * d[1] * d[2]))
end

p square_feets.reduce(&:+)
p lengths.reduce(&:+)
