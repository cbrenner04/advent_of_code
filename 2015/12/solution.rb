# frozen_string_literal: true

require "json"

data_file = File.join(File.dirname(__FILE__), "input.json")
json = File.read(data_file)
p_1 = json.scan(/(-?\d+)/).flatten.inject(0) { |sum, value| sum + value.to_i }

puts "Part one: #{p_1}"

parsed = JSON.parse(json)
@p_2 = 0

def sum_without_red(obj)
  case obj
  when Hash
    return if obj.value?("red")

    obj.each_value { |value| sum_without_red(value) }
  when Array
    obj.each { |value| sum_without_red(value) }
  when Integer
    @p_2 += obj
  end
end

sum_without_red(parsed)
puts "Part two: #{@p_2}"
