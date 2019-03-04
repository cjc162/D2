require 'minitest/autorun'
require_relative 'game'
# GameTest
class GameTest < Minitest::Test
  # UNIT TESTS FOR METHOD create_map()
  # Equivalence classes:
  # no param -> returns the 2D map specified in the requirement #3

  # The map specified in requirement #3 is returned.
  def test_create_map
    map = [
      ['Enumerable Canyon', 'Duck Type Beach', 'Monkey Patch City'],
      ['Duck Type Beach', 'Enumerable Canyon', 'Matzburg'],
      ['Monkey Patch City', 'Nil Town', 'Enumerable Canyon', 'Matzburg'],
      ['Nil Town', 'Hash Crossing', 'Monkey Patch City'],
      ['Matzburg', 'Monkey Patch City', 'Duck Type Beach', 'Hash Crossing', 'Dynamic Palisades'],
      ['Hash Crossing', 'Matzburg', 'Dynamic Palisades', 'Nil Town'],
      ['Dynamic Palisades', 'Hash Crossing', 'Matzburg']
    ]

    game = Game.new(1, 3)
    assert_equal map, game.create_map
  end

  # UNIT TESTS FOR METHOD start(prospector_count, prospect)
  # Equivalence classes:
  # prospector_count = -INFINITY..0 -> returns nil
  # prospector_count = 1 -> INFINITY, prospect = Of type prospector -> returns number of turns completed
  # prospect = Not a prospector type -> returns nil

  # If a a negative number or zero is given for prospector_count, nil is returned.
  # EDGE CASE
  def test_game_prospector_count_negative
    game = Game.new(1, 3) # Set turn limit to 3
    game.create_map

    prospector = Minitest::Mock.new('prospector')

    def prospector.go_mining(_p1, _p2)
      1
    end

    def prospector.move_to_next_location(_p1)
      1
    end

    assert_nil game.start(-1, prospector)
  end

  # If a nonnegative turn limit is given, the same turn limit is returned (in this case 3).
  def test_game_correct_turns
    game = Game.new(1, 3) # Set turn limit to 3
    game.create_map

    prospector = Minitest::Mock.new('prospector')

    def prospector.go_mining(_p1, _p2)
      1
    end

    def prospector.move_to_next_location(_p1)
      1
    end

    assert_equal 3, game.start(1, prospector)
  end
end
