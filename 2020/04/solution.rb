# frozen_string_literal: true

require_relative("./passport")

data = INPUT.split("\n\n").map { |l| l.tr("\n", " ") }

part_one = 0
part_two = 0

data.each do |passport|
  pass = Passport.new(passport)

  next unless pass.required_fields_present?

  part_one += 1

  next unless pass.valid?

  part_two += 1
end

p part_one
p part_two
