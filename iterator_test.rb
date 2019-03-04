require 'minitest/autorun'
require_relative 'iterator'
# IteratorTest
class IteratorTest < Minitest::Test
  # UNIT TESTS FOR METHOD get_next_location(location)
  # Equivalence classes:
  # location = -INFINITY..INFINITY -> returns nil
  # location = valid locatino name -> returns the index of the location in the map array
  # location = invalid location name -> returns nil

  # If location is negative, return nil
  # EDGE CASE
  def test_get_next_location_negative
    iterator = Iterator.new
    assert_nil iterator.get_next_location(-1)
  end

  # If location is not one of the valid 8, return nil
  # EDGE CASE

  def test_get_next_location_invalid
    iterator = Iterator.new
    assert_nil iterator.get_next_location('Invalid location')
  end

  # If location is one of the valid 8 locations, return the index it appears in the map array
  def test_get_next_location_valid
    iterator = Iterator.new
    assert_equal 3, iterator.get_next_location('Nil Town') # Nil Town is index #3
  end
end
