# frozen_string_literal: true

def template_pairs(template)
  template.split("")
          .each_with_index
          .map { |l, i| "#{l}#{template[i + 1]}" if template[i + 1] }
          .compact
end

template, rules = INPUT.split("\n\n").map(&:chomp)
rule_map = {}
rules.split("\n").map { |r| r.split(" -> ") }.each { |k, v| rule_map[k] = v }
10.times do
  combinations = template_pairs(template)
  new_template = [combinations.first.split("").first]
  combinations.each do |c|
    new_template.push(rule_map[c])
    new_template.push(c.split("").last)
  end
  template = new_template.join
end
char_counts = {}
template.each_char do |char|
  char_counts[char] = 0 unless char_counts[char]
  char_counts[char] += 1
end
p char_counts.values.max - char_counts.values.min
# TODO: this is not reasonably fast enough. need a more optimal solution
30.times do
  combinations = template_pairs(template)
  new_template = [combinations.first.split("").first]
  combinations.each do |c|
    new_template.push(rule_map[c])
    new_template.push(c.split("").last)
  end
  template = new_template.join
end
char_counts = {}
template.each_char do |char|
  char_counts[char] = 0 unless char_counts[char]
  char_counts[char] += 1
end
p char_counts.values.max - char_counts.values.min
