# frozen_string_literal: true

require "net/http"
require_relative "./parser"

YEAR, DAY = parse_cli
DIR = "#{YEAR}/#{DAY}"

def get(uri)
  session_cookie = "53616c7465645f5f154adc60db902ad2c806266722c9a9570c7ff9414c00002fc489a707fbff6c5216a951afe4484442"
  req = Net::HTTP::Get.new(uri)
  req["Cookie"] = "session=#{session_cookie}"

  Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) { |http| http.request(req) }
end

def create_file(filename)
  File.new(File.join(File.dirname(__FILE__), filename), "w")
end

def write_input
  input_file = create_file("#{DIR}/input.txt")
  input_response = get URI("https://adventofcode.com/#{YEAR}/day/#{DAY.to_i}/input")

  return unless input_response.is_a?(Net::HTTPSuccess)

  input_file.write(input_response.body)
end

def write_readme
  readme_file = create_file("#{DIR}/README.md")
  readme_response = get URI("https://adventofcode.com/#{YEAR}/day/#{DAY.to_i}")

  return unless readme_response.is_a?(Net::HTTPSuccess)

  readme_file.write(readme_response.body
    .gsub(%r{</?[^>]*>}, "")
    .gsub(/^(\s*.*\s*.*)\[Stats\]\s*/, "")
    .gsub(/To begin(.*\s.*)*/, "")
    .gsub(/Our sponsors.*\s+/, "")
    .gsub(/window.*\s---/, "#"))
end

def main
  system "mkdir #{DIR}"
  system "touch #{DIR}/solution.rb"
  write_input
  write_readme
end

main
