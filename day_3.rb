# get that data
require_relative './day_3_data.rb'

# split the data by whitespace
data = Day3Data::TRIANGLES.gsub(/\s+/m, ' ').strip.split(' ')
# split the data array into arrays of 3
arrays = data.each_slice(3).to_a
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
p count
