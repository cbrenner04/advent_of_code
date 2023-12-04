# frozen_string_literal: true

# each cube in the PocketDimension
class ConwayCube
  attr_reader :value

  def initialize
    @value = 0
  end

  def active?
    @value == 1
  end

  def activate
    @value = 1
  end

  def deactivate
    @value = 0
  end

  def display
    @value == 1 ? "#" : "."
  end
end

# a 2D slice of the PocketDimension
class Plane
  attr_reader :size

  def initialize(size)
    @size = size
    @matrix = Array.new(size) { Array.new(size) { ConwayCube.new } }
  end

  def [](x, y)
    @matrix[x][y]
  end

  def each
    @size.times { |row| yield @matrix[row] }
  end

  def each_with_index
    @size.times { |row| yield [@matrix[row], row] }
  end

  def grow
    @matrix.prepend(Array.new(@size) { ConwayCube.new })
    @matrix.push(Array.new(@size) { ConwayCube.new })
    @matrix.each do |row|
      row.prepend(ConwayCube.new)
      row.push(ConwayCube.new)
    end
    @size += 2
  end

  def number_active
    @matrix.map { |row| row.map(&:value).reduce(:+) }.reduce(:+)
  end
end

# an infinite 3D grid that has similar rules as Conway's Game Of Life
class PocketDimension
  attr_reader :size, :matrix_size

  def initialize(initial_active, starting_size = 0, num_matrix = 0)
    @size = num_matrix.zero? ? 1 : num_matrix
    @matrix_size = starting_size.zero? ? initial_active.flatten.max + 1 : starting_size
    @cycle = 0
    @dimension = starting_size.zero? ? create(initial_active) : create_empty
  end

  def run(cycles)
    cycles.times { run_cycle }
  end

  def number_active
    @dimension.map(&:number_active).reduce(:+)
  end

  def run_cycle
    grow
    evolve
  end

  def each_with_index
    @size.times { |matrix| yield [@dimension[matrix], matrix] }
  end

  def [](index)
    @dimension[index]
  end

  def grow
    @dimension.each(&:grow)
    @size += 2
    @matrix_size += 2
    @dimension.prepend(Plane.new(@matrix_size))
    @dimension.push(Plane.new(@matrix_size))
  end

  private

  def create(initial_active)
    # initial state will be a single 2D plane
    dimension = [Plane.new(@matrix_size)]
    initial_active.each { |x, y| dimension[0][x, y].activate }
    dimension
  end

  def create_empty
    # this creates empty dimensions for the fourth dimension
    Array.new(@size) { Plane.new(@matrix_size) }
  end

  def evolve
    # we will record what needs to change and then change at the end as to not affect subsequent checks in same cycle
    to_be_activated = []
    to_be_deactivated = []
    # each plane
    @dimension.each_with_index do |matrix, mi|
      # each row
      matrix.each_with_index do |row, ri|
        # each cube
        row.each_with_index do |cube, ci|
          num_active = active_neighbors(mi, ri, ci)
          if (num_active == 3) || ((num_active == 2) && cube.active?)
            to_be_activated << [mi, ri, ci]
          else
            to_be_deactivated << [mi, ri, ci]
          end
        end
      end
    end
    to_be_activated.each { |mi, ri, ci| @dimension[mi][ri, ci].activate }
    to_be_deactivated.each { |mi, ri, ci| @dimension[mi][ri, ci].deactivate }
  end

  def range(index, size)
    min = [0, index - 1].max
    max = [index + 1, size - 1].min
    (min..max)
  end

  def active_neighbors(matrix_index, row_index, column_index)
    plane_size = @dimension.first.size
    sum = 0
    range(matrix_index, @dimension.length).each do |mm|
      range(row_index, plane_size).each do |rr|
        range(column_index, plane_size).each do |cc|
          sum += @dimension[mm][rr, cc].value unless mm == matrix_index && rr == row_index && cc == column_index
        end
      end
    end
    sum
  end
end

# for part 2, adding another dimension :vomit:
class TheFourthDimension
  def initialize(initial_active)
    @four_d = [PocketDimension.new(initial_active)]
  end

  def run(cycles)
    cycles.times { run_cycle }
  end

  def number_active
    @four_d.map(&:number_active).reduce(:+)
  end

  def run_cycle
    grow
    evolve
  end

  private

  def grow
    @four_d.each(&:grow)
    @four_d.prepend(PocketDimension.new([], @four_d.first.matrix_size, @four_d.first.size))
    @four_d.push(PocketDimension.new([], @four_d.first.matrix_size, @four_d.first.size))
  end

  def evolve
    # we will record what needs to change and then change at the end as to not affect subsequent checks in same cycle
    to_be_activated = []
    to_be_deactivated = []
    # each pocket dimension
    @four_d.each_with_index do |dimension, di|
      # each plane
      dimension.each_with_index do |matrix, mi|
        # each row
        matrix.each_with_index do |row, ri|
          # each cube
          row.each_with_index do |cube, ci|
            num_active = active_neighbors(di, mi, ri, ci)
            if (num_active == 3) || ((num_active == 2) && cube.active?)
              to_be_activated << [di, mi, ri, ci]
            else
              to_be_deactivated << [di, mi, ri, ci]
            end
          end
        end
      end
    end
    to_be_activated.each { |di, mi, ri, ci| @four_d[di][mi][ri, ci].activate }
    to_be_deactivated.each { |di, mi, ri, ci| @four_d[di][mi][ri, ci].deactivate }
  end

  def range(index, size)
    min = [0, index - 1].max
    max = [index + 1, size - 1].min
    (min..max)
  end

  def active_neighbors(dimension_index, matrix_index, row_index, column_index)
    dimension_size = @four_d.first.size
    plane_size = @four_d.first[0].size
    sum = 0
    range(dimension_index, @four_d.size).each do |dd|
      range(matrix_index, dimension_size).each do |mm|
        range(row_index, plane_size).each do |rr|
          range(column_index, plane_size).each do |cc|
            next if dd == dimension_index && mm == matrix_index && rr == row_index && cc == column_index

            dimension = @four_d[dd]
            matrix = dimension[mm]
            sum += matrix[rr, cc].value
          end
        end
      end
    end
    sum
  end
end

data = INPUT.each_line.map(&:chomp)
initial_state = data.each_with_index.flat_map do |row, x|
  row.chars.each_with_index.map { |cell, y| [x, y] if cell == "#" }.compact
end
dimension = PocketDimension.new(initial_state)
dimension.run(6)
p dimension.number_active

fourth_dimension = TheFourthDimension.new(initial_state)
fourth_dimension.run(6)
p fourth_dimension.number_active
