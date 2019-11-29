# frozen_string_literal: true

require "optparse"

# rubocop:disable Metrics/MethodLength
def parse_cli
  year = nil
  day = nil

  OptionParser.new do |parser|
    parser.banner = "Usage: #{File.basename(__FILE__)} [options]"

    parser.on("-h", "--help", "Show this help message") { puts parser }

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

  [year, day]
end
# rubocop:enable Metrics/MethodLength
