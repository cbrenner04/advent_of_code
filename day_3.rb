require_relative './day_3_data.rb'

data = Day3Data::TRIANGLES
count = 0

data.each do |array|
  first = array[0]
  second = array[1]
  third = array[2]
  sum_of_first_two = first + second
  sum_of_second_two = second + third
  sum_of_third_two = first + third
  if (sum_of_first_two > third) && (sum_of_second_two > first) &&
     (sum_of_third_two > second)
    count += 1
  end
end

p count
