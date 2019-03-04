# Prospector class
class Prospector
  def initialize(map, iterator)
    @map = map
    @iterator = iterator
    @total_rubies = 0
    @total_fake_rubies = 0
    @locations_done = 0
    @turns = 0
    limit_rubies
  end

  def limit_rubies
    @limits = [[1, 1], [2, 2], [1, 1], [0, 3], [3, 0], [2, 2], [2, 2]]
  end

  def go_mining(turn, location)
    turn = turn.to_i
    location = location.to_i

    return nil if turn < 0 || location > 7 || location < 0

    loop do
      @turns += 1

      rubies = generator_rand((@limits[location][0]).to_i)
      @total_rubies += rubies

      fake_rubies = generator_rand((@limits[location][1]).to_i)
      @total_fake_rubies += fake_rubies

      display_findings_for_day(rubies, fake_rubies, location)
      break if fake_rubies.zero? && rubies.zero?
    end
    1
  end

  def move_to_next_location(current)
    return nil if current < 0 || current > 7

    current = current.to_i
    range = @map[current].length - 1 unless @map[current].length <= 1
    next_location = generator_rand(range.to_i)

    next_location += 1 if next_location.zero?

    puts "Heading from #{@map[current][0]} to #{@map[current][next_location]}."

    result = @iterator.get_next_location(@map[current][next_location])
    result
  end

  def generator_rand(max)
    return nil if max < 0

    result = rand(max + 1)
    result
  end

  def display_findings(prospect)
    return nil if prospect <= 0

    puts "After #{@turns} days, Rubyist ##{prospect} found:"
    print "	#{@total_rubies} "

    if @total_rubies == 1
      puts 'ruby.'
    else
      puts 'rubies.'
    end

    print "	#{@total_fake_rubies} fake "
    if @total_fake_rubies == 1
      puts 'ruby.'
    else
      puts 'rubies.'
    end

    if @total_rubies >= 10
      print 'Going home victorious!'
    elsif @total_rubies.between?(1, 9)
      print 'Going home sad.'
    elsif @total_rubies.zero?
      print 'Going home empty-handed.'
    end
    1
  end

  def display_findings_for_day(rubies, fake_rubies, location)
    return nil if location < 0 || location > 7

    if fake_rubies.zero? && rubies.zero?
      puts "	Found no rubies or fake rubies in #{@map[location][0]}."
    elsif fake_rubies == 1 && rubies.zero?
      puts "	Found #{fake_rubies} fake ruby in #{@map[location][0]}."
    elsif fake_rubies.zero? && rubies == 1
      puts "	Found #{rubies} ruby in #{@map[location][0]}."
    elsif fake_rubies > 1 && rubies.zero?
      puts "	Found #{fake_rubies} fake rubies in #{@map[location][0]}."
    elsif fake_rubies.zero? && rubies > 1
      puts "	Found #{rubies} rubies in #{@map[location][0]}."
    elsif fake_rubies == 1 && rubies == 1
      puts "	Found #{rubies} ruby and #{fake_rubies} fake ruby in #{@map[location][0]}."
    elsif fake_rubies > 1 && rubies == 1
      puts "	Found #{rubies} ruby and #{fake_rubies} fake rubies in #{@map[location][0]}."
    elsif fake_rubies == 1 && rubies > 1
      puts "	Found #{rubies} rubies and #{fake_rubies} fake ruby in #{@map[location][0]}."
    elsif fake_rubies > 1 && rubies > 1
      puts "	Found #{rubies} rubies and #{fake_rubies} fake rubies in #{@map[location][0]}."
    end
    1
  end
end
