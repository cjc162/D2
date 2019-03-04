class Iterator
	def get_next_location(location)
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
		end	
		result			
	end
end