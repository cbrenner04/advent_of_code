# frozen_string_literal: true

HEIGHT = 6
WIDTH = 25

layers = INPUT.scan(/.{#{WIDTH}}/).each_slice(HEIGHT)

highest_0 = layers.min_by { |x| x.map { |y| y.scan(/0/).count } }

ones = highest_0.flat_map { |x| x.scan(/1/) }.count
twos = highest_0.flat_map { |x| x.scan(/2/) }.count

puts ones * twos

matrix = Array.new(HEIGHT) { Array.new(WIDTH) }

layers.to_a.reverse.each do |layer|
  layer.each_with_index do |pixel, pixel_index|
    pixel.split("").each_with_index do |a, i|
      matrix[pixel_index][i] = a if %w[0 1].include?(a)
    end
  end
end

matrix.each { |m| puts m.map { |x| x == "0" ? " " : x }.join(" ") }
