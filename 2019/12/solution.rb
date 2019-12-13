# frozen_string_literal: true

class JupiterSystem
  attr_reader :moons

  def initialize(moons)
    @moons = Marshal.load(Marshal.dump(moons))
  end

  def gravity
    @moons.combination(2).to_a.each do |moon_a, moon_b|
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

  def velocity
    @moons.each do |moon|
      moon[:position][:x] += moon[:velocity][:x]
      moon[:position][:y] += moon[:velocity][:y]
      moon[:position][:z] += moon[:velocity][:z]
    end
  end

  def energy
    moon_total = @moons.map do |moon|
      potential = moon[:position][:x].abs + moon[:position][:y].abs + moon[:position][:z].abs
      kinetic = moon[:velocity][:x].abs + moon[:velocity][:y].abs + moon[:velocity][:z].abs
      potential * kinetic
    end
    moon_total.reduce(:+)
  end
end

moons = INPUT.each_line.map do |line|
  x, y, z = line.chomp.scan(/-?\d+/)
  {
    position: { x: x.to_i, y: y.to_i, z: z.to_i },
    velocity: { x: 0, y: 0, z: 0 }
  }
end

sys = JupiterSystem.new(moons)

1000.times do
  sys.gravity
  sys.velocity
end

puts sys.energy

sys_1 = JupiterSystem.new(moons)
x_count = 1
loop do
  sys_1.gravity
  sys_1.velocity
  break if sys_1.moons[0][:position][:x] == moons[0][:position][:x] &&
    sys_1.moons[0][:velocity][:x] == moons[0][:velocity][:x] &&
    sys_1.moons[1][:position][:x] == moons[1][:position][:x] &&
    sys_1.moons[1][:velocity][:x] == moons[1][:velocity][:x] &&
    sys_1.moons[2][:position][:x] == moons[2][:position][:x] &&
    sys_1.moons[2][:velocity][:x] == moons[2][:velocity][:x] &&
    sys_1.moons[3][:position][:x] == moons[3][:position][:x] &&
    sys_1.moons[3][:velocity][:x] == moons[3][:velocity][:x]
  x_count += 1
end

sys_2 = JupiterSystem.new(moons)
y_count = 1
loop do
  sys_2.gravity
  sys_2.velocity
  break if sys_2.moons[0][:position][:y] == moons[0][:position][:y] &&
    sys_2.moons[0][:velocity][:y] == moons[0][:velocity][:y] &&
    sys_2.moons[1][:position][:y] == moons[1][:position][:y] &&
    sys_2.moons[1][:velocity][:y] == moons[1][:velocity][:y] &&
    sys_2.moons[2][:position][:y] == moons[2][:position][:y] &&
    sys_2.moons[2][:velocity][:y] == moons[2][:velocity][:y] &&
    sys_2.moons[3][:position][:y] == moons[3][:position][:y] &&
    sys_2.moons[3][:velocity][:y] == moons[3][:velocity][:y]
  y_count += 1
end

sys_3 = JupiterSystem.new(moons)
z_count = 1
loop do
  sys_3.gravity
  sys_3.velocity
  break if sys_3.moons[0][:position][:z] == moons[0][:position][:z] &&
    sys_3.moons[0][:velocity][:z] == moons[0][:velocity][:z] &&
    sys_3.moons[1][:position][:z] == moons[1][:position][:z] &&
    sys_3.moons[1][:velocity][:z] == moons[1][:velocity][:z] &&
    sys_3.moons[2][:position][:z] == moons[2][:position][:z] &&
    sys_3.moons[2][:velocity][:z] == moons[2][:velocity][:z] &&
    sys_3.moons[3][:position][:z] == moons[3][:position][:z] &&
    sys_3.moons[3][:velocity][:z] == moons[3][:velocity][:z]
  z_count += 1
end

puts [x_count, y_count, z_count].reduce(1, :lcm)








