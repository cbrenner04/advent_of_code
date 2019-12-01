# frozen_string_literal: true

def calculate_fuel(mass)
  (mass / 3).floor - 2
end

data = INPUT.each_line.map(&:to_i)

part_one = data.map { |d| calculate_fuel(d) }.reduce(:+)

part_two = data.map do |d|
  total_fuels = 0
  fuel_required = calculate_fuel(d)
  while fuel_required.positive?
    total_fuels += fuel_required
    fuel_required = calculate_fuel(fuel_required)
  end
  total_fuels
end.reduce(:+)

puts part_one
puts part_two
