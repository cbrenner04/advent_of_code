# frozen_string_literal: true

require "net/http"
require_relative "./parser"

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

  article = output.match(%r{<article class=".*">((.|\n)*)</article>})[1]
  # handle the title
  article.gsub!("<h2>", "#")
  article.gsub!("</h2>", "\n\n")
  article.gsub!("---", "")
  # handle large code blocks
  article.gsub!("<pre><code>", "```text\n")
  article.gsub!("</code></pre>", "```\n")
  # handle emphasized code blocks
  article.gsub!("<code><em>", "**")
  article.gsub!("</em></code>", "**")
  # handle rest of code blocks
  article.gsub!(%r{</?code>}, "`")
  # handle emphasized text
  article.gsub!(%r{</?em>}, "**")
  # handle links
  link_matches = article.scan(%r{<a target="_blank" href="(.[^>]*)">(.[^<]*)</a>})
  link_matches.each do |link, text|
    article.gsub!("<a target=\"_blank\" href=\"#{link}\">#{text}</a>", "[#{text}](#{link})")
  end
  # handle paragraphs
  article.gsub!("<p>", "")
  article.gsub!("</p>", "\n")
  # handle unordered lists
  unordered_list_matches = article.scan(%r{<ul>(((?!</ul>).|\n)*)</ul>})
  unordered_list_matches.each do |list, _|
    updated = list.gsub("<li>", "- ").gsub("</li>", "")
    article.gsub!("\n<ul>#{list}</ul>", updated)
  end
  # handle ordered lists
  ordered_list_matches = article.scan(%r{<ul>(((?!</ul>).|\n)*)</ul>})
  ordered_list_matches.each do |list, _|
    updated = list.gsub("<li>", "1. ").gsub("</li>", "")
    article.gsub!("\n<ul>#{list}</ul>", updated)
  end
  # handle spans
  article.gsub!(/<span ((?!>).)*>/, "")
  article.gsub!("</span>", "")

  readme_file.write(article)
end

def main
  system "mkdir #{DIR}"
  system "touch #{DIR}/solution.rb"
  write_input
  write_readme
end

main
