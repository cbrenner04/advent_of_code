# frozen_string_literal: true

# get that data
data = INPUT.each_line.map { |line| line.chomp.split }
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
puts count

data = INPUT.each_line.map { |line| line.chomp.split }.flatten
# set the first value of the each of the new arrays
# these arrays are where I put my side values based on column
# first set is the first column
first_set = [data[0]]
# second set is the second column
second_set = [data[1]]
# third set is the third column
third_set = [data[2]]

# for each value in data
data.each_with_index.map do |value, index|
  # unless those values are any of the first three
  next unless index > 2

  # if the value is in the first column (meaning the index is divisible by 3)
  if (index % 3).zero?
    # send it to the first set
    first_set.push(value)
  # if the value is in the second column
  # (meaning the index is divisible by 3 with a remainder of 1)
  elsif index % 3 == 1
    # send it to the second set
    second_set.push(value)
  # if the value is in the second column
  # (meaning the index is divisible by 3 with a remainder of 2)
  elsif index % 3 == 2
    # send it to the third set
    third_set.push(value)
  end
end

sets = (first_set << second_set << third_set).flatten
# split the sets array into arrays of 3
arrays = sets.each_slice(3).to_a
# start count at 0
count = 0

# for every array in arrays
arrays.each do |array|
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
puts count
