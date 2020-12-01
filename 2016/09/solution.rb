# frozen_string_literal: true

starting_length = INPUT.length
num_of_chars_to_add = []
next_starting_point = 0
string = INPUT

loop do
  first_marker = string[/(\(\w{3,9}\))/, 1]
  break if first_marker.nil? # added in 2017 b/c different data

  index_of_end_of_first_marker = string.index("(") + first_marker.length
  x = first_marker.tr("(", "")[/(.*x)/].tr("x", "").to_i
  y = first_marker[/(x.*)/].tr("x", "").tr(")", "").to_i - 1

  num_of_chars_to_add.push(x * y - first_marker.length)

  next_starting_point = index_of_end_of_first_marker + x
  break if next_starting_point >= string.length

  string = string[next_starting_point..-1]
end

p starting_length + num_of_chars_to_add.reduce(&:+)

# rework from https://www.reddit.com/user/DeathWalrus

# rubocop:disable Metrics/MethodLength, Metrics/AbcSize
def decomp(string)
  i = 0
  total = 0
  while string && i < string.length
    if string[i] == "("
      i += 1
      new_string = ""
      while string[i] && string[i] != ")"
        new_string += string[i]
        i += 1
      end
      length = new_string.split("x")[0].to_i
      amount = new_string.split("x")[1].to_i
      total += amount * decomp(string[i + 1..i + length])
      i += length
    else
      total += 1
    end
    i += 1
  end
  total
end
# rubocop:enable Metrics/MethodLength, Metrics/AbcSize

p decomp(INPUT)
