# frozen_string_literal: true

def part_one(equation, paranthetical: false)
  equation = paranthetical ? equation[1..-2] : equation
  subeq = equation.split
  until subeq.length == 1
    left = subeq.shift.to_i
    operator = subeq.shift.to_sym
    right = subeq.shift.to_i
    subeq.unshift(left.send(operator, right))
  end
  subeq.first
end

def part_two(equation, paranthetical: false)
  equation = paranthetical ? equation[1..-2] : equation
  equation.gsub!(/(\d+\s\+\s\d+)/) { |d| eval(d) } while equation.include?("+")
  eval(equation)
end

part_one_data = INPUT.each_line.map(&:chomp)

part_one_total = part_one_data.map do |equation|
  # get rid of all the simple parantheticals
  equation.gsub!(/([(]\d+\s[*+]\s\d+\))/) { |d| eval(d) } until equation.scan(/([(]\d+\s[*+]\s\d+\))/).empty?

  # get rid of all the complex parantheticals
  while equation.include?("(")
    equation.gsub!(/([(]\d+\s([*+]\s\d+\s?)+\))/) { |subequation| part_one(subequation, paranthetical: true) }
  end

  part_one(equation)
end.reduce(:+)

p part_one_total

part_two_data = INPUT.each_line.map(&:chomp)

part_two_total = part_two_data.map do |equation|
  # get rid of all the simple parantheticals
  equation.gsub!(/([(]\d+\s[*+]\s\d+\))/) { |d| eval(d) } until equation.scan(/([(]\d+\s[*+]\s\d+\))/).empty?

  # get rid of all the complex parantheticals
  while equation.include?("(")
    equation.gsub!(/([(]\d+\s([*+]\s\d+\s?)+\))/) { |subequation| part_two(subequation, paranthetical: true) }
  end

  part_two(equation)
end.reduce(:+)

p part_two_total
