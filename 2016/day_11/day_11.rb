# frozen_string_literal: true

# NOT CURRENTLY WORKING

# Example:

# F4 .  .  .  .  .
# F3 .  .  .  LG .
# F2 .  HG .  .  .
# F1 E  .  HM .  LM

# A _M cannot be on the same floor as any _G other than its corresponding one
# unless it's on the same floor as its corresponding _G

# The E can move 1 or 2 items and can only move 1 floor at a time.

# each thing in this puzzle is an element
class Element
  attr_reader :name, :floor, :type
  attr_writer :floor

  def initialize(floor, name)
    @floor = floor
    @name = name
  end
end

# subclass of Element, generators can kill microchips
class Generator < Element
  def initialize(floor, name)
    super
    @type = "generator"
  end
end

# subclass of Element, needs its corresponding generator to be on a floor with
# any other generator
class Microchip < Element
  def initialize(floor, name)
    super
    @type = "microchip"
  end
end

# Example input
lookup = [
  Generator.new(3, "lithium"),
  Generator.new(2, "hydrogen"),
  Microchip.new(1, "lithium"),
  Microchip.new(1, "hydrogen")
]

# this only gets through the first 2 steps of 11
current_floor = 1
next_floor_gens = []
good_chips = []

# rubocop:disable BlockLength
2.times do
  current_floor_chips = lookup.select do |item|
    item.is_a?(Microchip) && item.floor == current_floor
  end
  current_floor_gens = lookup.select do |item|
    item.is_a?(Generator) && item.floor == current_floor
  end
  current_floor_sets = []
  current_floor_chips.each do |chip|
    current_floor_gens.each do |gen|
      current_floor_sets.push(chip)
      current_floor_sets.push(gen)
    end
  end
  next_floor = nil
  if current_floor_sets.any?
    next_floor = current_floor + 1
    current_floor_sets.each do |item|
      item.floor = next_floor
    end
  else
    next_floor = [current_floor - 1, current_floor + 1].reject do |floor|
      next_floor_gens = lookup.select do |item|
        item.is_a?(Generator) && item.floor == floor
      end.map(&:name)
      good_chips = current_floor_chips.select do |item|
        next_floor_gens.include? item.name
      end
      floor > 4 || floor < 1 || good_chips.empty?
    end.first
    good_chips.each do |chip|
      chip.floor = next_floor
    end
  end
  current_floor = next_floor
end
# rubocop:enable BlockLength

p lookup

# Puzzle input

# The first floor contains a thulium generator (TmG), a thulium-compatible
# microchip (TmM), a plutonium generator (PuG), and a strontium generator (SrG).

# The second floor contains a plutonium-compatible microchip (PuM) and a
# strontium-compatible microchip (SrM).

# The third floor contains a promethium generator (PmG), a promethium-compatible
# microchip (PmM), a ruthenium generator (RuG), and a ruthenium-compatible
# microchip (RuM).

# The fourth floor contains nothing relevant.

# F4 .   .   .   .   .   .   .   .   .   .   .
# F3 .   .   .   .   .   .   .   PmM PmG RuM RuG
# F2 .   .   .   PuM .   SrM .   .   .   .   .
# F1 E   TmM TmG .   PuG .   SrG .   .   .   .
