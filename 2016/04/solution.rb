# frozen_string_literal: true

# get data
data = INPUT.each_line.map(&:chomp)
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

# initialize digits variable
digits = []
# ordinal of 'a'
A_ORDINAL = 97

# for each of the strings in the data
data.each do |string|
  # split the string into chars
  array = string.split("")
  # append the digits to the digits variable
  array.each { |char| digits << char if char.match?(/[[:digit:]]/) }
  # initialize new array for putting the counts
  new_array = []
  # for each character
  array.each do |char|
    # stop iterating over the string when it hits the numbers
    break unless char.match?(/[[:alpha:]]/) || char.match?("-")

    # if current character is '-' turn it into a space
    new_array.push(" ") if char.match?("-")
    # go to next character if current character is '-'
    next if char.match?("-")

    # if char is an alphabetic character
    if char.match?(/[[:alpha:]]/)
      # change digits to integer
      offset = digits.join("").to_i
      # if offset is greater than 26 (number of characters in alphabet)
      # the offset will be the remainder of the offset given divided by 26
      offset = offset % 26 if offset > 26
      # the new ordinal value will be the remainder of the old divided
      # the ordinal value of 'a' plus 26
      num = (char.ord + offset) % (A_ORDINAL + 26)
      # if the new ordinal value is less than the ordinal of 'a'
      # add the ordinal of 'a'
      num += A_ORDINAL if num < A_ORDINAL
    end
    # push the new character to the new_array
    new_array.push(num.chr)
  end
  # stop if northpole is found
  break if new_array.join("").include? "northpole"

  # reset digits
  digits = []
end

p digits.join("").to_i
