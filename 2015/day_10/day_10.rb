# frozen_string_literal: true

input = "1113122113"

part_one = input.dup
part_two = input.dup

# the following is taken from http://rubyquiz.com/quiz138.html
class String
  def look_and_say
    gsub(/(.)\1*/) { |s| "#{s.size}#{s[0, 1]}" }
  end
end

40.times { part_one = part_one.look_and_say }

puts "Part one: #{part_one.length}"

50.times { part_two = part_two.look_and_say }

puts "Part two: #{part_two.length}"
