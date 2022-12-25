require 'pp'

def to_snafu(number)
	max_coeff = 1
	snumber = []
	while max_coeff < number
		max_coeff *= 5
	end
	
	max_coeff /= 5
	while max_coeff >= 1
		snumber << number / max_coeff
		number = number % max_coeff
		max_coeff /= 5
	end
	
	
	for i in 1..snumber.size
		# puts snumber.join()
		if snumber[-i] > 2
			if snumber[-i] == 3
				snumber[-i] = '='
			elsif snumber[-i] == 4
				snumber[-i] = '-'
			elsif snumber[-i] == 5
				snumber[-i] = 0
			end
			
			if i < snumber.size
				snumber[-i-1] += 1
			else
				snumber.unshift(1)
			end
		end
	end
	
	#.unshift()
	return snumber.join()
end

def from_snafu(snumber)
	num = 0
	for i in 1..snumber.size
		coeff = 5 ** (i-1)
		if snumber[-i] == '-'
			num += coeff*(-1)
		elsif snumber[-i] == '='
			num += coeff*(-2)
		else
			num += coeff*snumber[-i].to_i
		end	
	end
	return num	
end

def dec25_p01
	sum_fuel = 0
	lines =  File.readlines(__dir__ + "/dec25.txt")
    lines.each{ |line|
		snumber = line.strip()
		#print snumber, "  ", from_snafu(snumber), "  "
		#print to_snafu(from_snafu(snumber))
		#puts
		sum_fuel += from_snafu(snumber)
	}
	pp sum_fuel
	pp to_snafu(sum_fuel)
end

dec25_p01