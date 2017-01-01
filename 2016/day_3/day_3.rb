# frozen_string_literal: true
# get that data
data = File.open("day_3_data.txt", "r") do |file|
  file.each_line.map { |line| line.chomp.split(" ") }
end
# start count at 0
count = 0

# for every array in arrays
data.each do |array|
  # get the first element of the array
  first = array[0].to_i
  # get the second element of the array
  second = array[1].to_i
  # get the third element of the array
  third = array[2].to_i
  # add up the first two sides for comparison
  sum_of_first_two = first + second
  # add up the next two sides for comparison
  sum_of_second_two = second + third
  # add up the final two sides for comparison
  sum_of_third_two = first + third
  # as long as each of the two side sums are greater than the third side
  # increase the count
  if (sum_of_first_two > third) && (sum_of_second_two > first) &&
     (sum_of_third_two > second)
    count += 1
  end
end

# tell me whats up
p count
