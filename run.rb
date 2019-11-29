# frozen_string_literal: true

require "optparse"

require_relative "./parser.rb"

year, day = parse_cli

dir = "./#{year}/#{day}"

INPUT = File.read("#{dir}/input.txt").chomp

require_relative "#{dir}/solution.rb"
