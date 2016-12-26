# frozen_string_literal: true
# get data
data = []
File.open("day_4_data.txt", "r") { |f| f.each_line { |l| data.push l[0..-2] } }
# initialize digits variable
digits = []
# ordinal of 'a'
A_ORDINAL = 97

# for each of the strings in the data
data.each do |string|
  # split the string into chars
  array = string.split("")
  # append the digits to the digits variable
  array.each { |char| digits << char if char =~ /[[:digit:]]/ }
  # initialize new array for putting the counts
  new_array = []
  # for each character
  array.each do |char|
    # stop iterating over the string when it hits the numbers
    break unless char =~ /[[:alpha:]]/ || char =~ /-/
    # if current character is '-' turn it into a space
    new_array.push(" ") if char =~ /-/
    # go to next character if current character is '-'
    next if char =~ /-/
    # if char is an alphabetic character
    if char =~ /[[:alpha:]]/
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
