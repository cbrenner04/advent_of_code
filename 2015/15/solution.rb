# frozen_string_literal: true

Ingredient = Struct.new(:capacity, :durability, :flavor, :texture, :calories)

ingredients = []

INPUT.each_line do |line|
  capacity, durability, flavor, texture, calories = line.scan(/-?\d+/)
  ingredients << Ingredient.new(capacity.to_i, durability.to_i, flavor.to_i,
                                texture.to_i, calories.to_i)
end

# assumes 4 ingredients
# rubocop:disable Metrics/ParameterLists
def calculate_total(ingredients, property, count_1, count_2, count_3, count_4)
  ingredients[0][property] * count_1 + ingredients[1][property] * count_2 +
    ingredients[2][property] * count_3 + ingredients[3][property] * count_4
end
# rubocop:enable Metrics/ParameterLists

# rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity,
# rubocop:disable Metrics/PerceivedComplexity, Metrics/MethodLength
def solve(ingredients, part_two = false)
  score = 0
  max = 0

  (0..100).each do |i|
    (0..100 - i).each do |j|
      (0..100 - i - j).each do |k|
        l = 100 - i - j - k
        capacity = calculate_total(ingredients, "capacity", i, j, k, l)
        durability = calculate_total(ingredients, "durability", i, j, k, l)
        flavor = calculate_total(ingredients, "flavor", i, j, k, l)
        texture = calculate_total(ingredients, "texture", i, j, k, l)
        calories = calculate_total(ingredients, "calories", i, j, k, l)
        next if part_two && calories != 500
        next if capacity <= 0 || durability <= 0 || flavor <= 0 || texture <= 0
        score = capacity * durability * flavor * texture
        max = score if score > max
      end
    end
  end
  max
end
# rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity,
# rubocop:enable Metrics/PerceivedComplexity, Metrics/MethodLength

puts solve(ingredients, false)
puts solve(ingredients, true)
