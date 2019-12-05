# frozen_string_literal: true

# this is a pretty lame solution

def good_pass(pass)
  local_pass = pass.to_s
  good_length = local_pass.length == 6
  return false unless good_length
  has_double = local_pass.scan(/(.)\1/).any?
  return false unless has_double
  array = local_pass.split("")
  decreases = array.sort != array
  return false if decreases
  true
end

def part_two(pass)
  local_pass = pass.to_s
  triples = local_pass.scan(/(.)\1\1/).flatten.uniq
  doubles = local_pass.scan(/(.)\1/).flatten.uniq
  (triples.empty? && doubles.any?) ||
    (triples.any? && (doubles - triples).any? && (triples - doubles).empty?)
end

bounds = INPUT.split("-").map(&:to_i)
range = (bounds.first..bounds.last)

passes_with_doubles = range.select { |pass| pass if good_pass(pass) }
puts passes_with_doubles.length
puts passes_with_doubles.select { |pass| pass if part_two(pass) }.length
