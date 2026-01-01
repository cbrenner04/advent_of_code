# frozen_string_literal: true

# whitespace matters
# INPUT = "123 328  51 64 \n 45 64  387 23 \n  6 98  215 314\n*   +   *   +  \n"

part_one = INPUT.each_line.map { |line| line.strip.split(/\s+/) }.transpose.map do |equation|
  operator = equation.pop
  equation.map(&:to_i).reduce { |s, i| s.method(operator).(i) }
end.reduce(&:+)

p part_one

matrix = INPUT.each_line.map(&:chars)
n_columns = matrix.first.length - 1
n_rows = matrix.length - 1
equation = []
part_two = []

n_columns.downto(0) do |column|
  operator = matrix[-1][column]

  digits = []
  current = []
  # start on row above operator
  (n_rows - 1).downto(0) do |row|
    number = matrix[row][column]

    if number.strip.empty?
      unless current.empty?
        digits << current.join.reverse.to_i
        current = []
      end
    else
      current << number
    end
  end
  digits << current.join.reverse.to_i unless current.empty?
  equation.push(digits.first);

  unless !operator || operator.strip.empty?
    total = equation.compact.reduce { |s, i| s.method(operator).(i) }
    part_two.push(total)
    equation = []
  end
end

p part_two.reduce(&:+)
