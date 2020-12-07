# frozen_string_literal: true

require "net/http"
require_relative "./parser"
require_relative "./html_parsing"

YEAR, DAY = parse_cli
DIR = "#{YEAR}/#{DAY}"

def get(uri)
  session_cookie = ENV["AOC_SESSION_COOKIE"]
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

  output = readme_response.body
  article = parse_html(output)

  readme_file.write(article.chomp)
end

def main
  system "mkdir #{DIR}"
  system "touch #{DIR}/solution.rb"
  write_input
  write_readme
end

main
