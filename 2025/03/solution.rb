# frozen_string_literal: true

# INPUT = "987654321111111
# 811111111111119
# 234234234234278
# 818181911112111"

def jolt_me(combo)
  INPUT.each_line.map do |line|
    line.chomp.chars.combination(combo).to_a.map { |i| i.join.to_i }.max
  end
end

p jolt_me(2).reduce(:+)
p jolt_me(12).reduce(:+) # this takes forever
