# frozen_string_literal: true

# get data
data_file = File.join(File.dirname(__FILE__), "day_6_data.txt")
data = File.open(data_file).each_line.map(&:chomp)
# initialize the message array for the max character in each column
max_message = []
# initialize the message array for the min character in each column
min_message = []

# for each column index
(0..7).each do |index|
  # initialize hash -- local to the column
  hash = {}
  # each string
  data.each do |string|
    # get the character from the string
    char = string[index]
    # if the character already exists in the hash increment the count
    # otherwise initialize the character in the hash
    hash.key?(char) ? hash[char] += 1 : hash.merge!(char.to_s => 1)
  end

  # find the max value in the hash and send that character to the max message
  max_message.push(hash.max_by { |_key, value| value }[0])
  # find the min value in the hash and send that character to the min message
  min_message.push(hash.min_by { |_key, value| value }[0])
end

# display the results
p "MAX MESSAGE: #{max_message.join('')}"
p "MIN MESSAGE: #{min_message.join('')}"
