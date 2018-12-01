# frozen_string_literal: true

data_file = File.join(File.dirname(__FILE__), "day_8_data.txt")
data = File.open(data_file).each_line.map(&:strip)

# with help from https://github.com/gchan/advent-of-code-ruby/blob/master/2015/day-08/day-08-part-1.rb
# couldn't figure out the `eval` use -- also the `strip` above came in handy

original_lengths_total = data.map(&:length).reduce(&:+)
# rubocop:disable Eval
not_escaped_lengths_total = data.map { |line| eval(line).length }.reduce(&:+)
# rubocop:enable Eval
encoded_lengths_total = data.map { |line| line.dump.length }.reduce(&:+)

p original_lengths_total - not_escaped_lengths_total
p encoded_lengths_total - original_lengths_total
