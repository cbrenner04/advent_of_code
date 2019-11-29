# frozen_string_literal: true

# Part 1:
# sqrt(325489) = 570.516
# 571^2 = 326041 (next right hand bottom corner)
# 571 - 1 = 570 (total moves to center)
# 570 / 2 = 285 (moves to center of bottom line and again to center of spiral)
# 326041 - 285 = 325756 (center of bottom line)
# 325756 - 325489 = 267 (moves from my number to center of bottom line)
# 285 + 267 = 552 (total moves from my number to center of spiral)

# an attempt to put above into code (may not work)
input = 325_489
floored = Math.sqrt(input).floor
new_num = floored.even? ? floored + 1 : floored
sqred = new_num * new_num
steps_to_center = (new_num - 1) / 2
line_center = sqred - steps_to_center
diff = (input - line_center).abs
p steps_to_center + diff

# Part 2:
# Found answer on https://oeis.org/A141481

# From: https://www.reddit.com/r/adventofcode/comments/7h7ufl/comment/dqovogc?st=JASGSODE&amp;sh=101239ee

# can use: https://oeis.org/A141481/b141481.txt as a look-up
