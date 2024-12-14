# frozen_string_literal: true

require 'matrix'

# INPUT = "Button A: X+94, Y+34
# Button B: X+22, Y+67
# Prize: X=8400, Y=5400

# Button A: X+26, Y+66
# Button B: X+67, Y+21
# Prize: X=12748, Y=12176

# Button A: X+17, Y+86
# Button B: X+84, Y+37
# Prize: X=7870, Y=6450

# Button A: X+69, Y+23
# Button B: X+27, Y+71
# Prize: X=18641, Y=10279"

# A costs 3 tokens
# B costs 1 token
# have to land on prize exactly
# what is the lowest number of tokens that gets you a prize?

machines = INPUT.split("\n\n").map do |play|
  lines = play.each_line.map { |line| line.scan(/\d+/).map(&:to_i) }
  {
    a: lines.first,
    b: lines[1],
    prize: lines.last
  }
end

# original answer was not efficient enough for part 2
# def solve_machine(a, b, c, part_two)
#   min_cost = Float::INFINITY
#   best_solution = nil
#   c_x = part_two ? 10_000_000_000_000 + c.first : c.first
#   c_y = part_two ? 10_000_000_000_000 + c.last : c.last
#   max_moves = [(c_x / [a.first, b.first].min).ceil, (c_y / [a.last, b.last].min).ceil].max
#   max_moves = part_two ? max_moves : [100, max_moves].min

#   (0..max_moves).each do |num_a|
#     (0..max_moves).each do |num_b|
#       next unless a.first * num_a + b.first * num_b == c_x && a.last * num_a + b.last * num_b == c_y

#       (3 * num_a) + num_b
#       if cost < min_cost
#         min_cost = cost
#         best_solution = cost
#       end
#     end
#   end

#   best_solution
# end

# using matrix - got this off chat gpt
# i don't actually understand this so definitely cheating
def solve_machine(a, b, c, part_two)
  c_x = part_two ? 10_000_000_000_000 + c.first : c.first
  c_y = part_two ? 10_000_000_000_000 + c.last : c.last

  # Coefficient matrix
  coefficients = Matrix[[a.first, b.first], [a.last, b.last]]

  # Target vector
  targets = Matrix[[c_x], [c_y]]

  begin
    # Calculate the solution: X = A.inverse * B
    solution = coefficients.inverse * targets

    # Extract values and round to the nearest integers
    num_a = solution[0, 0].round
    num_b = solution[1, 0].round

    # Verify the solution by substituting back into the original equations
    (3 * num_a) + num_b if a.first * num_a + b.first * num_b == c_x && a.last * num_a + b.last * num_b == c_y
  rescue Matrix::ErrDimensionMismatch, Matrix::ErrNotRegular
    # Handle cases where the matrix is singular or not invertible
    # noop
  end
end

total_cost = 0
machines.each do |machine|
  result = solve_machine(machine[:a], machine[:b], machine[:prize], false)
  total_cost += result if result
end

p total_cost

total_cost = 0
machines.each do |machine|
  result = solve_machine(machine[:a], machine[:b], machine[:prize], true)
  total_cost += result if result
end

p total_cost
