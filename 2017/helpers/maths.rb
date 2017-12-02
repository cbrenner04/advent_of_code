# frozen_string_literal: true

def sum(arry)
  arry.inject(0) { |sum, x| sum + x }
end
