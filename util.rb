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

def diagonals(matrix, options = { row_step: 1, column_step: 1 })
  row_count = matrix.row_count
  column_count = matrix.column_count
  diagonals = []

  # Get all diagonals from top-left to bottom-right (positive)
  (0...row_count).each do |row|
    diagonal = []
    i = row
    j = 0
    while i < row_count && j < column_count
      diagonal << matrix[i, j]
      i += options[:row_step]
      j += options[:column_step]
    end
    diagonals << diagonal unless diagonal.empty?
  end

  (1...column_count).each do |col|
    diagonal = []
    i = 0
    j = col
    while i < row_count && j < column_count
      diagonal << matrix[i, j]
      i += options[:row_step]
      j += options[:column_step]
    end
    diagonals << diagonal unless diagonal.empty?
  end

  # Get all diagonals from top-right to bottom-left
  (0...row_count).each do |row|
    diagonal = []
    i = row
    j = column_count - 1
    while i < row_count && j >= 0
      diagonal << matrix[i, j]
      i += options[:row_step]
      j -= options[:column_step]
    end
    diagonals << diagonal unless diagonal.empty?
  end

  (0...(column_count - 1)).each do |col|
    diagonal = []
    i = 0
    j = col
    while i < row_count && j >= 0
      diagonal << matrix[i, j]
      i += options[:row_step]
      j -= options[:column_step]
    end
    diagonals << diagonal unless diagonal.empty?
  end

  diagonals
end
