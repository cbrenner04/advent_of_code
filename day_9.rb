data = File.read('day_9_data.txt')

p data.length

start_index = 0
opening_indeces = []

(start_index..data.length).each do |index|
  opening_indeces.push(index) if data[index] == '('
end

start_index = opening_indeces.first
new_string = []

(start_index + 1..data.length).each_with_index do |index|
  break if data[index] == ')'
  new_string.push(data[index])
end

marker = new_string.join('')
marker_array = marker.split('x')
end_index = start_index + 1 + new_string.length + 1
string_to_add = ''

(marker_array[1].to_i - 1).times do
  string_to_add += data[end_index..end_index + marker_array[0].to_i - 1]
end

data.insert(end_index + marker_array[0].to_i - 1, string_to_add)
    .gsub!("(#{marker})", '')

p data.length
