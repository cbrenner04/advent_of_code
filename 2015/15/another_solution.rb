# frozen_string_literal: true

# this is hella slower but more concise and dynamic

# rubocop:disable Metrics/AbcSize, Metrics/MethodLength,  Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
def solve(part_two: false)
  ingredients = INPUT.each_line.map { |line| line.scan(/-?\d+/).map(&:to_i) }
  highest_amount_for_one_ingredient = 100 - ingredients.length + 1
  # no ingredient will ever be 0 so start at 1
  combinations = (1..highest_amount_for_one_ingredient)
                 .to_a
                 .permutation(ingredients.length)
                 .select do |ratios|
                   ratios.reduce(:+) == 100
                 end
  # need to spit calories off
  *ingredient_properties, calories = ingredients.transpose
  combinations.map do |combo|
    ingredient_properties.map do |property|
      sum = property.zip(combo).reduce(0) { |s, p| s + p.reduce(:*) }
      calories_sum = calories.zip(combo).reduce(0) { |s, p| s + p.reduce(:*) }
      if part_two
        calories_sum == 500 && sum.positive? ? sum : 0
      else
        sum.positive? ? sum : 0
      end
    end.reduce(:*)
  end.max
end
# rubocop:enable Metrics/AbcSize, Metrics/MethodLength,  Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

puts solve(part_two: false)
puts solve(part_two: true) # not the right answer. close, but under
