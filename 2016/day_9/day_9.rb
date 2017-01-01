# frozen_string_literal: true
data = File.read("day_9_data.txt").chomp
starting_length = data.length
num_of_chars_to_add = []
next_starting_point = 0
string = data

loop do
  first_marker = string[/(\(\w{3,9}\))/, 1]
  index_of_end_of_first_marker = string.index("(") + first_marker.length
  x = first_marker.tr("(", "")[/(.*x)/].tr("x", "").to_i
  y = first_marker[/(x.*)/].tr("x", "").tr(")", "").to_i - 1

  num_of_chars_to_add.push(x * y - first_marker.length)

  next_starting_point = index_of_end_of_first_marker + x
  break if next_starting_point >= string.length
  string = string[next_starting_point..-1]
end

p starting_length + num_of_chars_to_add.reduce(&:+)
