# frozen_string_literal: true

data_file = File.join(File.dirname(__FILE__), "day_1_data.txt")
data = File.open(data_file).each_line.map(&:chomp).map(&:to_i)

puts "Part 1: #{data.reduce(:+)}"

freq = 0
freq_array = [0]

loop do
  break unless data.each do |i|
    freq += i
    if freq_array.include?(freq)
      puts "Part 2: #{freq}"
      break
    end
    freq_array.push(freq)
  end
end

# learned about cycle from:
# https://github.com/petertseng/adventofcode-rb-2018/blob/master/01_frequency_deltas.rb
# data.cycle do |i|
#   freq += i
#   if freq_array.include?(freq)
#     puts "Part 2: #{freq}"
#     break
#   end
#   freq_array.push(freq)
# end
