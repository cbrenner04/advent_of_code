# frozen_string_literal: true

require "digest"

# input given
input = "ffykfhsq"
# starting integer
i = 0
# initialize hex_input variable
hex_input = ""
# initialize password array - array now because positions aren't linear
password = []

# the password is 8 characters in length
until password.compact.length == 8
  loop do
    # input is a string of the given input plus an incremented integer
    new_input = input + i.to_s
    # make the input hexadecimal
    hex_input = Digest::MD5.hexdigest new_input
    # stop if the hex starts with 5 0s
    break if hex_input.start_with?("00000")
    i += 1
  end

  # if the character is a digit and a valid index of an 8 element array
  # and position is open
  if (hex_input[5] =~ /[[:digit:]]/) && hex_input[5].to_i.between?(0, 7) &&
     password[hex_input[5].to_i].nil?
    # put 7th character of hex string in 6th character position of password
    password[hex_input[5].to_i] = hex_input[6]
  end

  # increment the integer to start again
  i += 1
end

p password.join("")
