# frozen_string_literal: true
# this works with examples but is not efficient enough to run in any kind of
# reasonable amount of time to test on full data

data = File.read("day_9_data.txt")[0..-2]
starting_length = data.length
num_of_chars_to_add = []
string = data

loop do
  first_marker = string[/(\(\w{3,9}\))/, 1]
  break if first_marker.nil?
  index_of_end_of_first_marker = string.index("(") + first_marker.length
  x = first_marker.tr("(", "")[/(.*x)/].tr("x", "").to_i
  y = first_marker[/(x.*)/].tr("x", "").tr(")", "").to_i - 1

  num_of_chars_to_add.push(x * y - first_marker.length)

  new_string =
    string[index_of_end_of_first_marker..index_of_end_of_first_marker + x - 1]
  another_new_string = ""
  y.times { another_new_string += new_string }
  string.insert(index_of_end_of_first_marker, another_new_string)
  string = string.sub(first_marker, "")
end

p starting_length + num_of_chars_to_add.reduce(&:+)
