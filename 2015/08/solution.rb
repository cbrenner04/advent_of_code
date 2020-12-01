# frozen_string_literal: true

data = INPUT.each_line.map(&:strip)

# with help from https://github.com/gchan/advent-of-code-ruby/blob/master/2015/day-08/day-08-part-1.rb
# couldn't figure out the `eval` use -- also the `strip` above came in handy

original_lengths_total = data.map(&:length).reduce(&:+)
# rubocop:disable Security/Eval
not_escaped_lengths_total = data.map { |line| eval(line).length }.reduce(&:+)
# rubocop:enable Security/Eval
encoded_lengths_total = data.map { |line| line.dump.length }.reduce(&:+)

p original_lengths_total - not_escaped_lengths_total
p encoded_lengths_total - original_lengths_total
