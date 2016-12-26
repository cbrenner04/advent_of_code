# frozen_string_literal: true
require "digest"

# input given
input = "ugkcyxxp"
# starting integer
i = 0
# initialize hex_input variable
hex_input = ""
# initialize password variable
password = []

# the password is 8 characters in length
8.times do
  loop do
    # input is a string of the given input plus an incremented integer
    new_input = input + i.to_s
    # make the input hexadecimal
    hex_input = Digest::MD5.hexdigest new_input
    # stop if the hex starts with 5 0s
    break if hex_input.start_with?("00000")
    i += 1
  end
  # append the 6th character of the hex string
  password << hex_input[5]
  # increment the integer to start again
  i += 1
end

p password.join("")
