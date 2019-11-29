# frozen_string_literal: true

# This is SUPER hacky. I am not even going to comment it. It works but only
# because of brute force. I should be using regex. I can guarantee there is an
# easier way to do this... but this worked so I'm leaving it.

# UDPATE FROM 2017: didn't work the first time... it's close but not right...
# see below for updated line that got me the right answer

data = INPUT.each_line.map(&:chomp)

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
  # UPDATE FROM 2017: added `-1` here, got the right answer, dunno if its a good
  # solution
  next if indeces.include? index - 1
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

# UPDATE FROM 2017: unlike part 1 at least this one actually works

def the_sub_strings(string_length, new_string)
  place = 0
  sub_strings = []
  until place >= string_length
    if (new_string[place] == new_string[place + 2]) &&
       (new_string[place] != new_string[place + 1])
      sub_strings.push new_string[place..place + 2]
    end
    place += 1
  end
  sub_strings
end

# rubocop:disable MethodLength
def return_sub_strings(array, length)
  i = 0
  sub_strings = []
  until i >= length
    if i.even?
      new_string = array[i]
      string_length = new_string.length
      sub_strings += the_sub_strings(string_length, new_string)
    end
    i += 1
  end
  sub_strings
end

def return_count(array, length, new_sub_strings)
  counted = false
  count = 0
  j = 1
  until j >= length
    if j.odd?
      new_string = array[j]
      new_sub_strings.each do |bab|
        next unless new_string.include? bab
        count += 1
        counted = true
        break
      end
    end
    break if counted == true
    j += 1
  end
  count
end
# rubocop:enable MethodLength

count = 0

data.each do |string|
  array = string.split("[").map { |str| str.split("]") }.flatten
  length = array.length
  sub_strings = return_sub_strings(array, length)

  next if sub_strings.empty?
  new_sub_strings = sub_strings.map { |sub| sub[1] + sub[0] + sub[1] }

  count += return_count(array, length, new_sub_strings)
end

p count
