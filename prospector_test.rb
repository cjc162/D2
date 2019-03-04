require 'minitest/autorun'
require_relative 'prospector'
# ProspectorTest
class ProspectorTest < Minitest::Test
  # UNIT TESTS FOR METHOD limit_rubies()
  # Equivalence classes:
  # no param -> returns the 2D array of ruby and fake ruby limits specified in the requirement #9

  # A 2D array for the limit of rubies and fake rubies for each city is returned as specified in requirement #9.
  def test_limit_rubies
    limits = [[1, 1], [2, 2], [1, 1], [0, 3], [3, 0], [2, 2], [2, 2]]

    map = Minitest::Mock.new('map')
    iterator = Minitest::Mock.new('iterator')
    prospector = Prospector.new(map, iterator)
    assert_equal limits, prospector.limit_rubies
  end

  # UNIT TESTS FOR METHOD go_mining(turn, location)
  # Equivalence classes:
  # location = -INFINITY..-1 -> returns nil
  # location = turn -INFINITY..-1 -> returns nil
  # location = 0..7, turn = 0..INFINITY -> method executes as expected
  # location = 0..8 -> returns nil

  # If location is negative, return nil.
  # EDGE CASE
  def test_go_mining_negative_location
    map = Minitest::Mock.new('map')
    iterator = Minitest::Mock.new('iterator')
    prospector = Prospector.new(map, iterator)
    assert_nil prospector.go_mining(1, -1)
  end

  # If turn is negative, return nil.
  # EDGE CASE
  def test_go_mining_negative_turn
    map = Minitest::Mock.new('map')
    iterator = Minitest::Mock.new('iterator')
    prospector = Prospector.new(map, iterator)
    assert_nil prospector.go_mining(-1, 1)
  end

  # If turn is non-negative and location is non-negative and less than 8, return 1 on success.
  def test_go_mining_valid
    map = Minitest::Mock.new('map')
    iterator = Minitest::Mock.new('iterator')
    prospector = Prospector.new(map, iterator)
    assert_equal 1, prospector.go_mining(1, 1)
  end

  # EDGE CASE
  # If location is greater than 7, return nil.
  def test_go_mining_large_location
    map = Minitest::Mock.new('map')
    iterator = Minitest::Mock.new('iterator')
    prospector = Prospector.new(map, iterator)
    assert_nil prospector.go_mining(1, 10)
  end

  # UNIT TESTS FOR METHOD move_to_next_location(current)
  # Equivalence classes:
  # current = -INFINITY..-1 -> return nil.
  # current = 0..7 -> return next city index between 0 and 7 (inclusive)
  # current = 8..INFINITY -> return nil

  # EDGE CASE
  # If current location is negative, return nil
  def test_move_to_next_location_negative
    map = Minitest::Mock.new('map')
    iterator = Minitest::Mock.new('iterator')
    prospector = Prospector.new(map, iterator)
    def iterator.get_next_location(_p1)
      nil
    end
    assert_nil prospector.move_to_next_location(-1)
  end

  # If current location is between 0 and 8, return a valid cuity index between 0 and 7 (inclusive)
  def test_move_to_next_location_valid
    map = Minitest::Mock.new('map')
    iterator = Minitest::Mock.new('iterator')
    prospector = Prospector.new(map, iterator)
    def iterator.get_next_location(_p1)
      7
    end
    assert_includes 0..7, prospector.move_to_next_location(0)
  end

  # EDGE CASE
  # If current location is greater than 7, return nil
  def test_move_to_next_location_large
    map = Minitest::Mock.new('map')
    iterator = Minitest::Mock.new('iterator')
    prospector = Prospector.new(map, iterator)
    def iterator.get_next_location(_p1)
      nil
    end
    assert_nil prospector.move_to_next_location(8)
  end

  # UNIT TESTS FOR METHOD generator_rand(max)
  # Equivalence classes:
  # max = -INFINITY..-1 -> returns nil
  # max = 0..INFINITY -> returns prng based off seed initially passed in

  # If max is negative, nil is returned.
  # EDGE CASE
  def test_generator_rand_negative
    map = Minitest::Mock.new('map')
    iterator = Minitest::Mock.new('iterator')
    prospector = Prospector.new(map, iterator)

    assert_nil prospector.generator_rand(-1)
  end

  # If max is non-negative, a prng based off seed initially passed in is returned.
  def test_generator_rand_valid
    srand 1
    map = Minitest::Mock.new('map')
    iterator = Minitest::Mock.new('iterator')
    prospector = Prospector.new(map, iterator)
    # Seed makes prng deterministic. With seed 1 and max 5 first num is always 5
    assert_equal 5, prospector.generator_rand(5)
  end

  # UNIT TESTS FOR METHOD display_findings(prospect)
  # Equivalence classes:
  # prospect = -INFINITY..0 -> returns nil
  # prospect = 1..INFINITY -> returns findings for specfic prospector

  # If prospect is zero, return nil.
  # EDGE CASE
  def test_display_findings_zero
    map = Minitest::Mock.new('map')
    iterator = Minitest::Mock.new('iterator')
    prospector = Prospector.new(map, iterator)

    assert_nil prospector.display_findings(0)
  end

  # If prospect is negative, return nil.
  # EDGE CASE
  def test_display_findings_negative
    map = Minitest::Mock.new('map')
    iterator = Minitest::Mock.new('iterator')
    prospector = Prospector.new(map, iterator)

    assert_nil prospector.display_findings(-1)
  end

  # If prospect is greater than 0, display results
  def test_display_findings_valid
    map = Minitest::Mock.new('map')
    iterator = Minitest::Mock.new('iterator')
    prospector = Prospector.new(map, iterator)

    assert_equal 1, prospector.display_findings(1) # A return of 1 means the results were displayed without error
  end

  # If a valid prospector number is given, display the total rubies and fake rubies for the given prospector
  # found while using proper plurals, singulars, and syntax
  def test_display_findings_syntax
    map = Minitest::Mock.new('map')
    iterator = Minitest::Mock.new('iterator')
    prospector = Prospector.new(map, iterator)
    valid_syntax = "After 0 days, Rubyist #1 found:\n\t0 rubies.\n\t0 fake rubies.\nGoing home empty-handed."

    # A return of 1 means the results were displayed without error
    assert_output(valid_syntax) { prospector.display_findings(1) }
  end

  # UNIT TESTS FOR METHOD display_findings_for_day(rubies, fake_rubies, location)
  # Equivalence classes:
  # location = -INFINITY..-1 -> returns nil
  # location = 0..7 -> returns findings for the day for specfic prospector
  # location = 8..INFINITY -> return nil

  # If location is negative, return nil
  # EDGE CASE
  def test_display_findings_for_day_negative
    map = Minitest::Mock.new('map')
    iterator = Minitest::Mock.new('iterator')
    prospector = Prospector.new(map, iterator)

    assert_nil prospector.display_findings_for_day(0, 0, -1)
  end

  # If location is between 0 and 7 (inclusive), display findings for the day for specfic prospector
  # EDGE CASE
  def test_display_findings_for_day_valid
    map = Minitest::Mock.new('map')
    iterator = Minitest::Mock.new('iterator')
    prospector = Prospector.new(map, iterator)

    assert_equal 1, prospector.display_findings_for_day(0, 0, 0)
  end

  # If location is larger than 7, return nil
  # EDGE CASE
  def test_display_findings_for_day_largers
    map = Minitest::Mock.new('map')
    iterator = Minitest::Mock.new('iterator')
    prospector = Prospector.new(map, iterator)

    assert_nil prospector.display_findings_for_day(0, 0, 8)
  end

  # If a valid prospector number is given, display the daily rubies and fake rubies for the given prospector
  # found while using proper plurals, singulars, and syntax
  def test_display_findings_for_day_syntax
    map = Minitest::Mock.new('map')
    iterator = Minitest::Mock.new('iterator')
    prospector = Prospector.new(map, iterator)
    valid_syntax = "\tFound 1 ruby and 1 fake ruby in m.\n"

    assert_output(valid_syntax) { prospector.display_findings_for_day(1, 1, 0) }
  end
end
