# frozen_string_literal: true
# again... hacked to hell, but it works so I'm moving on.

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

data = []

File.open("day_7_data.txt", "r") { |f| f.each_line { |l| data.push l[0..-2] } }

count = 0

data.each do |string|
  array = []
  string.split("[").each { |str| array.push str.split("]") }
  array.flatten!
  length = array.length
  sub_strings = return_sub_strings(array, length)

  next if sub_strings.empty?
  new_sub_strings = []
  sub_strings.each { |sub| new_sub_strings.push sub[1] + sub[0] + sub[1] }

  count += return_count(array, length, new_sub_strings)
end

p count
