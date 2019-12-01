# frozen_string_literal: true

require "net/http"

require_relative "./parser.rb"

year, day = parse_cli

dir = "#{year}/#{day}"

system "mkdir #{dir}"
system "touch #{dir}/solution.rb"

def get(uri)
  session_cookie = "53616c7465645f5f0253fd517d23069d8025874c3d7ab3dba787a776" \
                   "49c091a89cd7782af315f72379761b440bb13435"
  req = Net::HTTP::Get.new(uri)
  req["Cookie"] = "session=#{session_cookie}"

  Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
    http.request(req)
  end
end

input_file = File.new(
  File.join(File.dirname(__FILE__), "#{dir}/input.txt"),
  "w"
)

input_response = get(
  URI("https://adventofcode.com/#{year}/day/#{day.to_i}/input")
)

input_file.write(input_response.body) if input_response.is_a?(Net::HTTPSuccess)

readme_file = File.new(
  File.join(File.dirname(__FILE__), "#{dir}/README.md"),
  "w"
)

readme_response = get URI("https://adventofcode.com/#{year}/day/#{day.to_i}")

if readme_response.is_a?(Net::HTTPSuccess)
  readme_file.write(readme_response.body
    .gsub(%r{<\/?[^>]*>}, "")
    .gsub(/^(\s*.*\s*.*)\[Stats\]\s*/, "")
    .gsub(/To begin(.*\s.*)*/, ""))
end
