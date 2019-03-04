require_relative 'prospector'
require_relative 'iterator'

# Game class
class Game
  def initialize(num_prospectors, num_turns)
    @num_prospectors = num_prospectors
    @num_turns = num_turns
  end

  def setup
    # Create map of various locations
    create_map

    # For all prospectors specified by second command line arguement
    for i in 1..@num_prospectors
      # Create new prospectors
      prospect = Prospector.new(@map, Iterator.new)
      # Start the game with the current prospector
      start(i, prospect)
      # Display current prospectors total findings when done
      prospect.display_findings(i)
    end
  end

  def create_map
    # Create map as specified by requirement #3
    @map = [
      ['Enumerable Canyon', 'Duck Type Beach', 'Monkey Patch City'],
      ['Duck Type Beach', 'Enumerable Canyon', 'Matzburg'],
      ['Monkey Patch City', 'Nil Town', 'Enumerable Canyon', 'Matzburg'],
      ['Nil Town', 'Hash Crossing', 'Monkey Patch City'],
      ['Matzburg', 'Monkey Patch City', 'Duck Type Beach', 'Hash Crossing', 'Dynamic Palisades'],
      ['Hash Crossing', 'Matzburg', 'Dynamic Palisades', 'Nil Town'],
      ['Dynamic Palisades', 'Hash Crossing', 'Matzburg']

    ]
  end

  def start(prospector_count, prospect)
    prospector_count = prospector_count.to_i

    return nil if prospector_count <= 0 || @num_turns <= 0

    turn = 1
    location = 0
    puts "\nRubyist ##{prospector_count} is starting in #{@map[location][0]}."
    # While the max number of turns has not been hit
    while turn <= @num_turns
      prospect.go_mining(turn, location)
      turn += 1
      # Get next location after current location gets nothing
      location = prospect.move_to_next_location(location) unless turn > @num_turns
    end
    turn - 1
  end
end
