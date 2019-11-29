# frozen_string_literal: true

require "json"

data_file = File.join(File.dirname(__FILE__), "input.json")
json = File.read(data_file)
p_1 = json.scan(/(-?\d+)/).flatten.inject(0) { |sum, value| sum + value.to_i }

puts "Part one: #{p_1}"

parsed = JSON.parse(json)
@p_2 = 0

def sum_without_red(obj)
  if obj.is_a? Hash
    return if obj.value?("red")

    obj.values.each { |value| sum_without_red(value) }
  elsif obj.is_a? Array
    obj.each { |value| sum_without_red(value) }
  elsif obj.is_a? Integer
    @p_2 += obj
  end
end

sum_without_red(parsed)
puts "Part two: #{@p_2}"
