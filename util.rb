# frozen_string_literal: true

def array_subsequences(array)
  # creates array of indexes
  # finds all the combinations of those indexes
  # returns array of all data in combination ranges
  # i.e. array_subsequences([1, 2, 3, 4, 5]) => [
  #  [1], [1, 2], [1, 2, 3], [1, 2, 3, 4], [1, 2, 3, 4, 5], [2], [2, 3],
  #  [2, 3, 4], [2, 3, 4, 5], [3], [3, 4], [3, 4, 5], [4], [4, 5], [5]
  # ]
  (0..array.length).to_a.combination(2).map { |i, j| array[i...j] }
end

def simple_matrix(number_of_rows, number_of_columns)
  Array.new(number_of_rows) { Array.new(number_of_columns, false) }
end
