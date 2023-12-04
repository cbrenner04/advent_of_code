# frozen_string_literal: true

require "digest"

# input given
input = "ffykfhsq"
# starting integer
i = 0
# initialize hex_input variable
hex_input_one = ""
# initialize password variable
password_one = []

# the password is 8 characters in length
8.times do
  loop do
    # input is a string of the given input plus an incremented integer
    new_input = input + i.to_s
    # make the input hexadecimal
    hex_input_one = Digest::MD5.hexdigest new_input
    # stop if the hex starts with 5 0s
    break if hex_input_one.start_with?("00000")

    i += 1
  end
  # append the 6th character of the hex string
  password_one << hex_input_one[5]
  # increment the integer to start again
  i += 1
end

puts password_one.join

# starting integer
j = 0
# initialize hex_input variable
hex_input_two = ""
# initialize password array - array now because positions aren't linear
password_two = []

# the password is 8 characters in length
until password_two.compact.length == 8
  loop do
    # input is a string of the given input plus an incremented integer
    new_input = input + j.to_s
    # make the input hexadecimal
    hex_input_two = Digest::MD5.hexdigest new_input
    # stop if the hex starts with 5 0s
    break if hex_input_two.start_with?("00000")

    j += 1
  end

  # if the character is a digit and a valid index of an 8 element array
  # and position is open
  if (hex_input_two[5] =~ /[[:digit:]]/) &&
     hex_input_two[5].to_i.between?(0, 7) &&
     password_two[hex_input_two[5].to_i].nil?
    # put 7th character of hex string in 6th character position of password
    password_two[hex_input_two[5].to_i] = hex_input_two[6]
  end

  # increment the integer to start again
  j += 1
end

puts password_two.join
