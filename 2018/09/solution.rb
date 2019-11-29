# frozen_string_literal: true

# represents a player in the game
class Player
  attr_accessor :score

  def initialize
    @score = 0
  end
end

# represents the game
class Game
  attr_accessor :max_score

  def initialize(number_of_players, highest_marble)
    # initialize players in the game
    @players = []
    number_of_players.times { @players << Player.new }
    # initialize circle for the game
    @circle = Circle.new
    # initialize the current player
    @current_player = @players.first
    # play the game
    highest_marble.times { take_turn }
    # calculate max score
    @max_score = 0
    @players.each do |player|
      @max_score = player.score if player.score > max_score
    end
  end

  private

  def take_turn
    @circle.insert_marble(@current_player)
    # go to next player
    next_player_index = @players.index(@current_player) + 1
    @current_player = if next_player_index > @players.length - 1
                        @players.first
                      else
                        @players[next_player_index]
                      end
  end
end

# represents a marble in the circle
class Marble
  attr_accessor :number, :next_marble, :previous_marble

  def initialize(number, next_marble = nil, previous_marble = nil)
    @number = number
    @next_marble = next_marble
    @previous_marble = previous_marble
  end
end

# represents the circle into which marbles are added
# pretty much a circular doubly linked-list with special logic
class Circle
  # circle starts with marble 0 in it
  def initialize
    @number = 0
    new_marble = Marble.new(@number)
    new_marble.next_marble = new_marble
    new_marble.previous_marble = new_marble
    @current_marble = new_marble
  end

  def insert_marble(player)
    @number += 1
    new_marble = Marble.new(@number)
    if @number == 1
      handle_one(new_marble)
    elsif (@number % 23).zero?
      handle_divisible_by_23(player)
    else
      handle_regular(new_marble)
    end
  end

  private

  # marble 1 is a special case as only two marbles in circle therefore
  # current_marble now points to new marble and vice versa
  def handle_one(new_marble)
    @current_marble.next_marble = new_marble
    @current_marble.previous_marble = new_marble
    new_marble.next_marble = @current_marble
    new_marble.previous_marble = @current_marble
    @current_marble = new_marble
  end

  # marble with a number divisble by 23 is also a special case
  def handle_divisible_by_23(player)
    player.score += @number
    marble_to_remove = @current_marble.previous_marble
    6.times { marble_to_remove = marble_to_remove.previous_marble }
    marble_to_remove.previous_marble.next_marble =
      marble_to_remove.next_marble
    marble_to_remove.next_marble.previous_marble =
      marble_to_remove.previous_marble
    player.score += marble_to_remove.number
    @current_marble = marble_to_remove.next_marble
  end

  def handle_regular(new_marble)
    new_previous_marble = @current_marble.next_marble
    new_next_marble = @current_marble.next_marble.next_marble
    new_previous_marble.next_marble = new_marble
    new_next_marble.previous_marble = new_marble
    new_marble.next_marble = new_next_marble
    new_marble.previous_marble = new_previous_marble
    @current_marble = new_marble
  end
end

# puzzle input: 458 players; last marble 72019
highest_marble = 72_019
number_of_players = 458

game = Game.new(number_of_players, highest_marble)
puts "Part 1: #{game.max_score}"

game = Game.new(number_of_players, highest_marble * 100)
puts "Part 2: #{game.max_score}"
