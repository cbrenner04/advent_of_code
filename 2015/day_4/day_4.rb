# frozen_string_literal: true
require "digest"

def solve(leading_zeroes)
  secret = "bgvyzdsv"
  i = 0

  loop do
    break if Digest::MD5.hexdigest(secret + i.to_s).start_with?(leading_zeroes)
    i += 1
  end

  p i
end

solve("00000")
solve("000000")
