def get_all_ys(string, y, ys)
  p string
  ys.push(y)
  first_marker = string[/(\(\w{3,9}\))/, 1]
  return ys if first_marker.nil?
  index_of_end_of_first_marker = string.index('(') + first_marker.length
  x = first_marker.tr('(', '')[/(.*x)/].tr('x', '').to_i
  y = first_marker[/(x.*)/].tr('x', '').tr(')', '').to_i

  new_string = string[index_of_end_of_first_marker..index_of_end_of_first_marker + x - 1]
  get_all_ys(new_string, y, ys)
end

data = File.read('day_9_data.txt')[0..-2]
starting_length = data.length
num_of_chars_to_add = []
next_starting_point = 0
string = data

loop do
  first_marker = string[/(\(\w{3,9}\))/, 1]
  index_of_end_of_first_marker = string.index('(') + first_marker.length
  x = first_marker.tr('(', '')[/(.*x)/].tr('x', '').to_i
  y = first_marker[/(x.*)/].tr('x', '').tr(')', '').to_i

  new_string = string[index_of_end_of_first_marker..index_of_end_of_first_marker + x - 1]
  ys = []
  y = get_all_ys(new_string, y, ys)

  num_of_chars_to_add.push(y)

  next_starting_point = index_of_end_of_first_marker + x
  break if next_starting_point >= string.length
  string = string[next_starting_point..-1]
end

p num_of_chars_to_add.flatten.reduce(&:*)
array = []
num_of_chars_to_add.each { |sub_array| array.push(sub_array.reduce(&:*)) }
p array.reduce(&:+)
p starting_length + num_of_chars_to_add.reduce(&:+)
