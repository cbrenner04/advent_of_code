# frozen_string_literal: true

require_relative "./parser.rb"

year, day = parse_cli

dir = "./#{year}/#{day}"

input_file = "#{dir}/input.txt"

INPUT = File.read(input_file).chomp if File.exist?(input_file)

require_relative "#{dir}/solution.rb"
