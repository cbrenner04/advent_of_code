# frozen_string_literal: true

# this could use some optimization
# rubocop:disable AbcSize, MethodLength
def compare_and_remove_chars(string)
  index_array = []
  char_array = string.split("")
  index = 0
  until index >= string.length
    char = char_array[index]
    next_char = char_array[index + 1]
    # can't just make case equal and compare chars like this
    # next_char_match = next_char.upcase == char.downcase
    # match is if the cases are opposite so `aA` is a match
    next_char_match =
      next_char == (char.match?(/[[:lower:]]/) ? char.upcase : char.downcase)
    if next_char_match
      index_array << index
      index_array << index + 1
      index += 2
    else
      index += 1
    end
  end
  index_array.reverse_each { |i| char_array.delete_at(i) }
  new_string = char_array.join
  if new_string.length == string.length
    new_string
  else
    compare_and_remove_chars(new_string)
  end
end
# rubocop:enable AbcSize, MethodLength

updated_string = compare_and_remove_chars(INPUT.dup)

puts "Part one: #{updated_string.length}"

lengths = []

[*"a".."z"].each do |char|
  new_string = INPUT.dup
  new_string.delete!(char)
  new_string.delete!(char.upcase)
  lengths << compare_and_remove_chars(new_string).length
end

puts "Part two: #{lengths.min}"
