# frozen_string_literal: true

Disc = Struct.new(:name, :weight, :total_weight, :children)

def move_children(disc, data)
  return unless disc.children.any?
  disc.children.each do |child|
    if child.is_a? String
      data.each do |datum|
        next unless datum.name == child
        disc.children << datum
        disc.children.delete(child)
        data.delete(datum)
      end
    else
      move_children(child, data)
    end
  end
end

def calculate_weights(disc)
  return unless disc.children.any?
  disc.children.each do |c|
    c.children.any? ? calculate_weights(c) : disc.total_weight += c.weight
  end
end

def remove_weights(disc)
  return unless disc.children.any?
  disc.children.each do |c|
    if c.children.any?
      remove_weights(c)
    elsif c.weight == c.total_weight
      disc.children.delete(c)
    end
  end
end

data_file = File.join(File.dirname(__FILE__), "day_7_example_data.txt")
data = File.open(data_file).each_line.map(&:chomp).map do |datum|
  d = datum.split(" (")
  name = d.first
  weight = d.last.split(")").first
  children = datum.include?(" -> ") ? d.last.split(" -> ").last.split(", ") : []
  Disc.new(name, weight.to_i, weight.to_i, children)
end

data.each { |disc| move_children(disc, data) } until data.count == 1

p data.first.name # part one

# part two --- does not work
calculate_weights(data.first)
remove_weights(data.first)

p data.first
