# frozen_string_literal: true
# get data
data = File.open("day_4_data.txt", "r") { |f| f.each_line.map { |l| l[0..-2] } }
# initialize variable for total
total = 0

# for each of the strings in the data
data.each do |string|
  # split the string into chars
  array = string.split("")
  # initialize new array for putting the counts
  new_array = []
  # for each character
  array.each do |char|
    # stop iterating over the string when it hits the numbers
    break unless char =~ /[[:alpha:]]/ || char =~ /-/
    # initialize count variable
    count = 0
    # for each character in the array
    array.each_with_index do |_value, index|
      # do nothing if the character is '-'
      next if char =~ /-/
      # increment count when the characters match
      count += 1 if char == array[index]
    end
    # send character and count to the new array
    new_array.push([char, count]) unless char =~ /-/
  end

  # get the unique values and sort by count (in reverse) and alphabetically
  new_array.uniq!.sort_by! { |char, count| [-count, char] }

  # drop all the counts
  newest_array = new_array.map { |value| value[0] }

  # get checksum
  # split the string on the '[' character
  # make it an array (which gives you the two parts of the string)
  # pop the last part of the array (that's all you need here)
  # split that into an array
  # pop the last character of the array (']') and keep the array
  checksum = string.split("[").to_a.pop.split("").tap(&:pop)

  # do nothing unless the first five values are equal to the checksum
  next unless checksum == newest_array[0..4]
  # append the digits to the digits variable
  digits = array.map { |char| char if char =~ /[[:digit:]]/ }

  # add the digits to the total
  total += digits.join("").to_i
end

p total
