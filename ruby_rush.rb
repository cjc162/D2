require_relative 'game'
require_relative 'arguement_checker'

def show_correct_input
  puts 'Usage:'
  puts 'ruby ruby_rush *seed* *num_prospects* *num_turns*'
  puts '*seed* should be an integer'
  puts '*num_prospectors* should be a non-negative integer'
  puts '*num_turns* should be a non-negative integer'
end

checker = ArguementChecker.new
correct_input = checker.arguement_check ARGV

if correct_input
  # Set seed for the rest of the program
  srand(ARGV[0].to_i)
  num_prospectors = ARGV[1].to_i
  num_turns = ARGV[2].to_i
  # Create new game
  @game = Game.new(num_prospectors, num_turns)
  # Setup new game
  @game.setup
else
  show_correct_input
  # Exit with error code 1 on bad input
  exit 1
end
# Exit with error code 0 after program finishes
exit 0
