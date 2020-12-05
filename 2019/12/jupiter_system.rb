# frozen_string_literal: true

# object for mapping jupiter system
class JupiterSystem
  attr_reader :moons

  def initialize(moons)
    @moons = Marshal.load(Marshal.dump(moons))
  end

  # rubocop:disable Metrics/AbcSize, Metrics/MethodLength, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
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
  # rubocop:enable Metrics/AbcSize, Metrics/MethodLength, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

  def velocity
    @moons.each do |moon|
      moon[:position][:x] += moon[:velocity][:x]
      moon[:position][:y] += moon[:velocity][:y]
      moon[:position][:z] += moon[:velocity][:z]
    end
  end

  # rubocop:disable Metrics/AbcSize
  def energy
    moon_total = @moons.map do |moon|
      potential = moon[:position][:x].abs + moon[:position][:y].abs +
                  moon[:position][:z].abs
      kinetic = moon[:velocity][:x].abs + moon[:velocity][:y].abs +
                moon[:velocity][:z].abs
      potential * kinetic
    end
    moon_total.reduce(:+)
  end
  # rubocop:enable Metrics/AbcSize
end
