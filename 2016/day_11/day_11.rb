# frozen_string_literal: true

# Example:

# F4 .  .  .  .  .
# F3 .  .  .  LG .
# F2 .  HG .  .  .
# F1 E  .  HM .  LM

# Puzzle Input:

# The first floor contains a promethium generator and a promethium-compatible
# microchip.

# The second floor contains a cobalt generator, a curium generator, a ruthenium
# generator, and a plutonium generator.

# The third floor contains a cobalt-compatible microchip, a curium-compatible
# microchip, a ruthenium-compatible microchip, and a plutonium-compatible
# microchip.

# The fourth floor contains nothing relevant.

# F4 .   .   .   .   .   .   .   .   .   .   .
# F3 .   .   .   .   .   .   .   CoM CmM RuM PuM
# F2 .   .   .   CoG CmG RuG PuG .   .   .   .
# F1 E   PmG PmM .   .   .   .   .   .   .   .

# A __M cannot be on the same floor as any __G other than its corresponding one
# unless it's on the same floor as its corresponding __G

# The E can move at most 2 items and at least 1 item

# each thing in this puzzle is an element
class Element
  attr_reader :name, :floor

  def initialize(floor, name)
    @floor = floor
    @name = name
  end
end

# subclass of Element, generators can kill microchips
class Generator < Element
end

# subclass of Element, needs its corresponding generator to be on a floor with
# any other generator
class Microchip < Element
end

# subclass of Element, has to move linearly, must move with 1 or 2 elements
# its count is important to part one of this puzzle
class Elevator < Element
  attr_accessor :count
end

hash = {
  "LG" => Generator.new(3, "lithium"),
  "HG" => Generator.new(2, "hydrogen"),
  "LM" => Microchip.new(1, "lithium"),
  "HM" => Microchip.new(1, "hydrogen"),
  "E" => Elevator.new(1, "elevator")
}

hash["E"].count = 0
current = hash["E"].floor
# current_flr_chips =
#   hash.map { |k, v| k if v.is_a?(Microchip) && v.floor == current }.compact
# next_flr = [current - 1, current + 1].reject do |floor|
#   next_floor_gens = hash.map do |_k, v|
#     v.name if v.is_a?(Generator) && v.floor == floor
#   end.compact
#   good_chips = current_flr_chips.map do |chip|
#     hash[chip] if next_floor_gens.include? hash[chip].name
#   end.compact
#   floor > 4 || floor < 1 || good_chips.empty?
# end

# p next_flr

p hash["E"].count unless hash.any? { |_key, value| value.floor < 4 }
