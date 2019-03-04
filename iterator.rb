# Iterator
class Iterator
  def get_next_location(location)
    # Get the index of the current location
    result = 0
    if location == 'Enumerable Canyon'
      result = 0
    elsif location == 'Duck Type Beach'
      result = 1
    elsif location == 'Monkey Patch City'
      result = 2
    elsif location == 'Nil Town'
      result = 3
    elsif location == 'Matzburg'
      result = 4
    elsif location == 'Hash Crossing'
      result = 5
    elsif location == 'Dynamic Palisades'
      result = 6
    else
      return nil
    end
    result
  end
end
