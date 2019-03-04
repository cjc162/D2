require 'minitest/autorun'
require_relative 'arguement_checker'
# ChechArguementChecker
class CheckArguementChecker < Minitest::Test
  # UNIT TESTS FOR METHOD arguement_check(args)
  # Equivalnce classes:
  # N/A

  # If no command line arguements are given, then false is returned.
  def test_cmd_args_none
    checker = ArguementChecker.new
    assert_equal false, checker.arguement_check([])
  end

  # If one command line arguement is given, then false is returned.
  def test_cmd_args_one
    checker = ArguementChecker.new
    assert_equal false, checker.arguement_check([1])
  end

  # If two command line arguements are given, then false is returned.
  def test_cmd_args_two
    checker = ArguementChecker.new
    assert_equal false, checker.arguement_check(%w[1 2])
  end

  # If command line arguement #1 cannot be interpreted as an int is given, then false is returned.
  def test_cmd_args_not_interpreted1
    checker = ArguementChecker.new
    assert_equal false, checker.arguement_check(%w[Cat 3 2])
  end

  # If command line arguement #2 cannot be interpreted as an int is given, then false is returned.
  def test_cmd_args_not_interpreted2
    checker = ArguementChecker.new
    assert_equal false, checker.arguement_check(%w[1 Cat 3])
  end

  # If command line arguement #3 cannot be interpreted as an int is given, then false is returned.
  def test_cmd_args_not_interpreted3
    checker = ArguementChecker.new
    assert_equal false, checker.arguement_check(%w[1 2 Cat])
  end

  # If command line arguement #2 is negative, then false is returned.
  def test_cmd_args_negative1
    checker = ArguementChecker.new
    assert_equal false, checker.arguement_check(%w[1 -2 3])
  end

  # If command line arguement #3 is negative, then false is returned.
  def test_cmd_args_negative2
    checker = ArguementChecker.new
    assert_equal false, checker.arguement_check(%w[1 3 -2])
  end

  # If 3 command line arguements are given, they all can be interpreted as ints, and arguements #2 and #3
  # are non-negative, return true
  def test_cmd_args_valid_input
    checker = ArguementChecker.new
    assert_equal true, checker.arguement_check(%w[1 3 2])
  end
end
