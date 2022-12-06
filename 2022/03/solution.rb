# frosen_string_literal: true

# INPUT = "vJrwpWtwJgWrhcsFMMfFFhFp
# jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
# PmmdzqPrVvPwwTWBwg
# wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
# ttgJtRGJQctTZtZT
# CrZsJsPPZsGzwwsLwLmpwMDw"

def get_priority(char)
  char == char.capitalize ? char.bytes.first - 65 + 27 : char.bytes.first - 96
end

p_1 = INPUT.each_line.map do |line|
  line.chomp!
  char = (line[0..(line.size / 2) - 1].split(//) & line[(line.size / 2)..-1].split(//)).first
  get_priority(char)
end.reduce(:+)

p p_1

data = INPUT.split(/\n/)
p_2 = data.each_slice(3).map do |set_of_three|
  char = (set_of_three.first.split(//) & set_of_three[1].split(//) & set_of_three.last.split(//)).first
  get_priority(char)
end.reduce(:+)

p p_2
