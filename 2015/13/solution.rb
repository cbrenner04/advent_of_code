# frozen_string_literal: true

def totals(people)
  people.keys.permutation.map do |couple|
    couple << couple[0] # account for going back around
    couple.each_cons(2).map do |name, neighbor|
      people[name][neighbor] + people[neighbor][name]
    end.reduce(:+)
  end
end

lines = INPUT.each_line.map(&:strip)
people = {}

lines.each do |line|
  name, direction, happiness, neighbor =
    line.chomp.scan(/(\w+)\s\w+\s(\w+)\s(\d+).*\s(\w+).$/).first
  happiness_direction = direction == "lose" ? "-" : ""
  happiness_score = "#{happiness_direction}#{happiness}".to_i
  people[name] ||= {}
  people[name][neighbor] = happiness_score
end

puts "Part one: #{totals(people).max}"

# add myself to the mix

people["Chris"] = {}

people.each_key do |person|
  next if person == "Chris"

  people[person]["Chris"] = 0
  people["Chris"][person] = 0
end

puts "Part two: #{totals(people).max}"
