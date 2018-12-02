# frozen_string_literal: true

require "optparse"

year = nil
day = nil

OptionParser.new do |parser|
  parser.banner = "Usage: init.rb [options]"

  parser.on("-h", "--help", "Show this help message") do
    puts parser
  end

  parser.on("-y", "--year YEAR", "The year of the puzzle.") do |y|
    raise "Must have year" unless y
    year = y
  end

  parser.on("-d", "--day DAY", "The day of the puzzle.") do |d|
    raise "Must have day" unless d
    day = d
  end
end.parse!

raise "Must have YEAR and DAY; use -h for help" unless day && year

dir = "#{year}/day_#{day}"

system "mkdir #{dir}"
system "touch #{dir}/README.md #{dir}/day_#{day}.rb #{dir}/day_#{day}_data.txt"
