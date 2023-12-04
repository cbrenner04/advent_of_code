# frozen_string_literal: true

# INPUT = "30373
# 25512
# 65332
# 33549
# 35390"

data = INPUT.each_line.map { |l| l.chomp.chars.map(&:to_i) }
p_1 = (2 * (data.count - 2)) + (2 * data.count)
p_2 = 0

(1..data.length - 2).each do |i|
  (1..data[i].length - 2).each do |ii|
    current = data[i][ii]
    new_ii = ii.dup
    new_i = i.dup
    left = nil
    lscenic = 0
    right = nil
    rscenic = 0
    up = nil
    uscenic = 0
    down = nil
    dscenic = 0
    until new_ii <= 0 || left == false
      new_ii -= 1
      lscenic += 1
      left = current > data[i][new_ii]
    end
    new_ii = ii.dup
    until new_ii >= data[i].length - 1 || right == false
      new_ii += 1
      rscenic += 1
      right = current > data[i][new_ii]
    end
    until new_i <= 0 || up == false
      new_i -= 1
      uscenic += 1
      up = current > data[new_i][ii]
    end
    new_i = i.dup
    until new_i >= data.length - 1 || down == false
      new_i += 1
      dscenic += 1
      down = current > data[new_i][ii]
    end

    p_1 += 1 if left || right || up || down
    lp_2 = lscenic * rscenic * uscenic * dscenic
    p_2 = lp_2 if lp_2 > p_2
  end
end

p p_1
p p_2
