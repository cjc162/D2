require_relative 'game'

def show_correct_input
	puts "Usage:"
	puts "ruby ruby_rush *seed* *num_prospects* *num_turns*"
	puts "*seed* should be an integer"
	puts "num_prospectors* should be a non-negative integer"
	puts "num_turns* should be a non-negative integer"
end

def check_args
	result = true

	if ARGV.count != 3 || ARGV[1].to_i <= 0 || ARGV[2].to_i <= 0
		result = false
	end
	result
end

if check_args
	srand(ARGV[0].to_i)
	num_prospectors = ARGV[1].to_i
	num_turns = ARGV[2].to_i
	@game = Game.new(num_prospectors, num_turns)
	@game.setup
else
	show_correct_input
	exit 1
end