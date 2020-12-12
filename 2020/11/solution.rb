# frozen_string_literal: true

data = INPUT.each_line.map { |line| line.chomp.split("") }

# utilities

def hash_values(values)
  # make hash of each value ("L", ".", "#") as a key and its count as the value
  values_hash = Hash.new(0)
  values.each { |v| values_hash[v] += 1 }
  values_hash
end

def hash_matrix(matrix)
  # make hash of each value ("L", ".", "#") as a key and its count as the value
  values_hash = Hash.new(0)
  matrix.each { |row| row.each { |value| values_hash[value] += 1 } }
  values_hash
end

# part one

def surrounding_values(ri, ci, matrix)
  values = []

  values << matrix[ri - 1][ci - 1] if matrix[ri - 1][ci - 1] && ri.positive? && ci.positive?
  values << matrix[ri - 1][ci] if matrix[ri - 1][ci] && ri.positive?
  values << matrix[ri - 1][ci + 1] if matrix[ri - 1][ci + 1] && ri.positive? && ci < matrix[ri - 1].length
  values << matrix[ri][ci - 1] if matrix[ri][ci - 1] && ci.positive?
  values << matrix[ri][ci + 1] if matrix[ri][ci + 1] && ci < matrix[ri - 1].length
  values << matrix[ri + 1][ci - 1] if matrix[ri + 1] && matrix[ri + 1][ci - 1] && ri < matrix.length && ci.positive?
  values << matrix[ri + 1][ci] if matrix[ri + 1] && matrix[ri + 1][ci] && ri < matrix.length
  if matrix[ri + 1] && matrix[ri + 1][ci + 1] && ri < matrix.length && ci < matrix[ri - 1].length
    values << matrix[ri + 1][ci + 1]
  end

  hash_values(values)
end

# part two

def northwest(row_index, column_index, matrix)
  value = "."
  rii = row_index
  cii = column_index
  until value != "."
    rii -= 1
    cii -= 1
    break unless !rii.negative? && !cii.negative?

    value = matrix[rii][cii]
  end

  value
end

def north(row_index, column_index, matrix)
  value = "."
  rii = row_index
  cii = column_index
  until value != "."
    rii -= 1

    break if rii.negative?

    value = matrix[rii][cii]
  end

  value
end

def northeast(row_index, column_index, matrix)
  value = "."
  rii = row_index
  cii = column_index
  until value != "."
    rii -= 1
    cii += 1
    break unless !rii.negative? && cii < matrix[rii].length

    value = matrix[rii][cii]
  end

  value
end

def west(row_index, column_index, matrix)
  value = "."
  rii = row_index
  cii = column_index
  until value != "."
    cii -= 1
    break if cii.negative?

    value = matrix[rii][cii]
  end

  value
end

def east(row_index, column_index, matrix)
  value = "."
  rii = row_index
  cii = column_index
  until value != "."
    cii += 1
    break unless cii < matrix[rii].length

    value = matrix[rii][cii]
  end

  value
end

def southwest(row_index, column_index, matrix)
  value = "."
  rii = row_index
  cii = column_index
  until value != "."
    rii += 1
    cii -= 1
    break unless rii < matrix.length && !cii.negative?

    value = matrix[rii][cii]
  end

  value
end

def south(row_index, column_index, matrix)
  value = "."
  rii = row_index
  cii = column_index
  until value != "."
    rii += 1
    break unless rii < matrix.length

    value = matrix[rii][cii]
  end

  value
end

def southeast(row_index, column_index, matrix)
  value = "."
  rii = row_index
  cii = column_index
  until value != "."
    rii += 1
    cii += 1
    break unless rii < matrix.length && cii < matrix[rii].length

    value = matrix[rii][cii]
  end

  value
end

def viewable_values(ri, ci, matrix)
  values = []

  values << northwest(ri, ci, matrix)
  values << north(ri, ci, matrix)
  values << northeast(ri, ci, matrix)
  values << west(ri, ci, matrix)
  values << east(ri, ci, matrix)
  values << southwest(ri, ci, matrix)
  values << south(ri, ci, matrix)
  values << southeast(ri, ci, matrix)

  hash_values(values)
end

def solve(matrix, part_two: false)
  loop do
    duper = matrix.map(&:dup)

    matrix.each_with_index do |row, ri|
      row.each_with_index do |value, ci|
        number_occupied = part_two ? viewable_values(ri, ci, matrix)["#"] : surrounding_values(ri, ci, matrix)["#"]
        # check empty
        if value == "L" && number_occupied.zero?
          duper[ri][ci] = "#"
          next
        end

        # check occupied
        allowable_occupied_count = part_two ? 5 : 4
        if value == "#" && number_occupied >= allowable_occupied_count
          duper[ri][ci] = "L"
          next
        end

        duper[ri][ci] = value
      end
    end

    break if matrix == duper

    matrix = duper
  end

  hash_matrix(matrix)["#"]
end

p solve(data.map(&:dup), part_two: false)
p solve(data.map(&:dup), part_two: true)
