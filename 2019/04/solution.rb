# frozen_string_literal: true

def good_pass(pass)
  good_length = pass.length == 6
  return false unless good_length

  has_double = pass.scan(/(.)\1/).any?
  return false unless has_double

  array = pass.split("")
  decreases = array.sort != array
  return false if decreases

  true
end

# double in previous good pass can't be part of a longer string of same digit
# therefore if there are no triples the pass is still good
# or if there are triples then there needs to be another double for a good pass
def part_two(pass)
  triples = pass.scan(/(.)\1\1/)
  doubles = pass.scan(/(.)\1/)
  triples.empty? ||
    (triples.any? && (doubles - triples).any? && (triples - doubles).empty?)
end

bounds = INPUT.split("-").map(&:to_i)
range = (bounds.first..bounds.last)

passes_with_doubles = range.select { |pass| good_pass(pass.to_s) }
puts passes_with_doubles.length
puts passes_with_doubles.select { |pass| part_two(pass.to_s) }.length
