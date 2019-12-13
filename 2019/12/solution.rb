# frozen_string_literal: true

def gravity(moons)
  moons.combination(2).to_a.each do |moon_a, moon_b|
    if moon_a[:position][:x] < moon_b[:position][:x]
      moon_a[:velocity][:x] += 1
      moon_b[:velocity][:x] -= 1
    elsif moon_b[:position][:x] < moon_a[:position][:x]
      moon_a[:velocity][:x] -= 1
      moon_b[:velocity][:x] += 1
    end

    if moon_a[:position][:y] < moon_b[:position][:y]
      moon_a[:velocity][:y] += 1
      moon_b[:velocity][:y] -= 1
    elsif moon_b[:position][:y] < moon_a[:position][:y]
      moon_a[:velocity][:y] -= 1
      moon_b[:velocity][:y] += 1
    end

    if moon_a[:position][:z] < moon_b[:position][:z]
      moon_a[:velocity][:z] += 1
      moon_b[:velocity][:z] -= 1
    elsif moon_b[:position][:z] < moon_a[:position][:z]
      moon_a[:velocity][:z] -= 1
      moon_b[:velocity][:z] += 1
    end
  end
end

def velocity(moons)
  moons.each do |moon|
    moon[:position][:x] += moon[:velocity][:x]
    moon[:position][:y] += moon[:velocity][:y]
    moon[:position][:z] += moon[:velocity][:z]
  end
end

def energy(moons)
  moon_total = moons.map do |moon|
    potential = moon[:position][:x].abs + moon[:position][:y].abs + moon[:position][:z].abs
    kinetic = moon[:velocity][:x].abs + moon[:velocity][:y].abs + moon[:velocity][:z].abs
    potential * kinetic
  end
  moon_total.reduce(:+)
end

# INPUT = "<x=-1, y=0, z=2>\n<x=2, y=-10, z=-7>\n<x=4, y=-8, z=8>\n<x=3, y=5, z=-1>"
# INPUT = "<x=-8, y=-10, z=0>\n<x=5, y=5, z=10>\n<x=2, y=-7, z=3>\n<x=9, y=-8, z=-3>"

moons = INPUT.each_line.map do |line|
  x, y, z = line.chomp.scan(/-?\d+/)
  {
    position: { x: x.to_i, y: y.to_i, z: z.to_i },
    velocity: { x: 0, y: 0, z: 0 }
  }
end

1000.times do
  gravity(moons)
  velocity(moons)
end

puts energy(moons)

=begin
# this would take til the end of time to run

count = 0
previous_sets = []

loop do
  gravity(moons)
  velocity(moons)
  break if previous_sets.include?(moons)
  previous_sets << Marshal.load(Marshal.dump(moons))
  count += 1
end

puts count
=end

