# frozen_string_literal: true

require_relative "./nanofactory.rb"

factory = Nanofactory.new(INPUT)
p factory.run(1)

# couldn't get the bsearch working so i just got real lazy
# this takes under a minute to run so i am not terribly worried

ore = 0
fuel = 0
while ore < 1_000_000_000_000
  fuel += 100_000
  ore = factory.run(fuel)
end

ore = 0
fuel -= 100_000
while ore < 1_000_000_000_000
  fuel += 1
  ore = factory.run(fuel)
end

p fuel - 1
