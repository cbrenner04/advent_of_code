require_relative './day_4_data.rb'

# get data
data = Day4Data::STRINGS
# initialize variable for total
total = 0

# for each of the strings in the data
data.each do |string|
  # split the string into chars
  array = string.split('')
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

  # initialize another array
  newest_array = []
  # drop all the counts
  new_array.each { |value| newest_array.push(value[0]) }

  # get checksum start
  checksum_start = array.index('[')
  # index variable set to the index of the start of the checksum
  i = checksum_start + 1
  # initialize array for storing the checksum
  checksum = []
  # put the checksum in the checksum array
  5.times do
    checksum.push(array[i])
    i += 1
  end

  # do nothing unless the first five values are equal to the checksum
  next unless checksum == newest_array[0..4]
  # initialize digits variable
  digits = ''
  # append the digits to the digits variable
  array.each { |char| digits << char if char =~ /[[:digit:]]/ }

  # add the digits to the total
  total += digits.to_i
end

p total
