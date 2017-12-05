# frozen_string_literal: true

# Part 1:
# sqrt(325489) = 570.516
# 571^2 = 326041 (next right hand bottom corner)
# 571 - 1 = 570 (total moves to center)
# 570 / 2 = 285 (moves to center of bottom line and again to center of spiral)
# 326041 - 285 = 325756 (center of bottom line)
# 325756 - 325489 = 267 (moves from my number to center of bottom line)
# 285 + 267 = 552 (total moves from my number to center of spiral)

# Part 2:
# Found answer on https://oeis.org/A141481

# From: https://www.reddit.com/r/adventofcode/comments/7h7ufl/comment/dqovogc?st=JASGSODE&amp;sh=101239ee
