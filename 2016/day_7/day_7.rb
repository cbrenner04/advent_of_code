# frozen_string_literal: true
# This is SUPER hacky. I am not even going to comment it. It works but only
# because of brute force. I should be using regex. I can guarantee there is an
# easier way to do this... but this worked so I'm leaving it.

data = File.open("day_7_data.txt", "r") { |f| f.each_line.map { |l| l[0..-2] } }

square_bracket_strings = data.map do |str|
  (1..str.split("[").length - 1).map { |i| str.split("[")[i].split("]")[0] }
end

indeces = []

square_bracket_strings.each_with_index do |arry, index|
  counted = false
  arry.each do |str|
    start_index = 0

    until start_index == str.length - 4
      first_sub_str = str[start_index..start_index + 1]
      second_sub_str = str[start_index + 2..start_index + 3]
      if first_sub_str == second_sub_str.reverse
        indeces.push(index)
        counted = true
        break
      end
      start_index += 1
    end
    break if counted == true
  end
end

count = 0

data.each_with_index do |str, index|
  next if indeces.include? index
  count_of_hypernet_sequences = str.split("]").length
  strings = str.split("]")
  array_of_strings = (0..count_of_hypernet_sequences - 2).map do |i|
    strings[i].split("[")[0]
  end
  array_of_strings.push strings[count_of_hypernet_sequences - 1]
  counted = false
  array_of_strings.each do |new_string|
    length = new_string.length
    start_index = 0
    until start_index == length - 4
      first_sub_str = new_string[start_index..start_index + 1]
      second_sub_str = new_string[start_index + 2..start_index + 3]
      if first_sub_str == second_sub_str.reverse
        count += 1
        counted = true
      end
      start_index += 1
    end
    break if counted == true
  end
end

p count
