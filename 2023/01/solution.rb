# frozen_string_literal: true

# INPUT = "1abc2
# pqr3stu8vwx
# a1b2c3d4e5f
# treb7uchet"

# INPUT = "two1nine
# eightwothree
# abcone2threexyz
# xtwone3four
# 4nineeightseven2
# zoneight234
# 7pqrstsixteen"

string_to_int = {
  "one" => 1,
  "two" => 2,
  "three" => 3,
  "four" => 4,
  "five" => 5,
  "six" => 6,
  "seven" => 7,
  "eight" => 8,
  "nine" => 9
}

p1 = INPUT.each_line.map do |line|
  # i should be able to do this with a match not scan and a better regex
  digits = line.scan(/\d/)
  # i don't like first + first
  digits.count == 1 ? (digits.first + digits.first).to_i : (digits.first + digits.last).to_i
end.reduce(:+)

puts p1

p2 = INPUT.each_line.map do |line|
  digits = line.scan(/(?=(one|two|three|four|five|six|seven|eight|nine)|([0-9]))/).flatten.compact
  first_digit = digits.first != "zero" && digits.first.to_i.zero? ? string_to_int[digits.first].to_s : digits.first
  last_digit = digits.last != "zero" && digits.last.to_i.zero? ? string_to_int[digits.last].to_s : digits.last
  (first_digit + last_digit).to_i
end.reduce(:+)

puts p2
