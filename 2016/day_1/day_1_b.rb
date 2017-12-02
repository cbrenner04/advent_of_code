# frozen_string_literal: true

array = %w[
  L5 R1 R3 L4 R3 R1 L3 L2 R3 L5 L1 L2 R5 L1 R5 R1 L4 R1 R3 L4 L1 R2 R5 R3 R1 R1
  L1 R1 L1 L2 L1 R2 L5 L188 L4 R1 R4 L3 R47 R1 L1 R77 R5 L2 R1 L2 R4 L5 L1 R3
  R187 L4 L3 L3 R2 L3 L5 L4 L4 R1 R5 L4 L3 L3 L3 L2 L5 R1 L2 R5 L3 L4 R4 L5 R3
  R4 L2 L1 L4 R1 L3 R1 R3 L2 R1 R4 R5 L3 R5 R3 L3 R4 L2 L5 L1 L1 R3 R1 L4 R3 R3
  L2 R5 R4 R1 R3 L4 R3 R3 L2 L4 L5 R1 L4 L5 R4 L2 L1 L3 L3 L5 R3 L4 L3 R5 R4 R2
  L4 R2 R3 L3 R4 L1 L3 R2 R1 R5 L4 L5 L5 R4 L5 L2 L4 R4 R4 R1 L3 L2 L4 R3
]

# starting x coordinate is 0
x = 0
# starting y coordinate is 0
y = 0
# starting facing north
facing = 0
# empty array for coordinate values
values = []
# repeat starts as false
repeat = false

# for each step
array.each_with_index do |_value, index|
  # get the current step
  step = array[index]
  # get the direction of the current step (R or L)
  direction = step[0, 1]
  # get the distance of the current step (everything after the R or L)
  distance = direction == "R" ? step.tr("R", "").to_i : step.tr("L", "").to_i

  # arbitrarily pick right as positive, left as negative
  # these can be switched with same results
  facing = direction == "R" ? facing + 1 : facing - 1

  # find out which of the 4 directions you are facing
  card_dir = facing % 4

  # need to know the coordinates of each step not just each destination
  distance.times do
    # decrementing/increment is also arbitrary
    # these can be switched with same results
    # as long as east/west are opposite and north/south are opposite
    case card_dir
    # when card_dir is 0 you are facing north so increment y coordinates
    when 0
      y += 1
    # when card_dir is 1 you are facing east so increment x coordinates
    when 1
      x += 1
    # when card_dir is 2 you are facing south so decrement y coordinates
    when 2
      y -= 1
    # when card_dir is 3 you are facing west so decrement x coordinates
    when 3
      x -= 1
    end

    # set coordinates string
    coordinates = "#{x},#{y}"
    # set repeat to true if coordinates have already been stepped on
    repeat = true if values.include? coordinates
    # break if repeat has happened
    break if repeat == true
    # send coordinates to values array for checking against next step
    values.push coordinates
  end

  # break if repeat has happened
  break if repeat == true
end

# put sum of absolute values of x and y
p x.abs + y.abs
