def show_correct_input
	puts "Incorrect usage. Correct Usage:"
	puts "ruby ruby_rush [seed] [number of prospects] [number of turns]"
end

def check_args
	result = true

	if ARGV.count != 3 || ARGV[1].to_i <= 0 || ARGV[2].to_i <= 0
		result = false
	end
	result
end

if check_args
	seed = ARGV[0].to_i
	num_prospectors = ARGV[1].to_i
	num_turns = ARGV[2].to_i
else
	show_correct_input
	exit 1
end