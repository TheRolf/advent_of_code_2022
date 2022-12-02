#!/usr/bin/ruby

$base_folder = "C:/GitHub/advent_of_code_2022/"

def greeting
	puts "Hello csajszi"
	puts "dikk"
	@x = 5
	@y = 4.444
	puts "x erteke #@x es y erteke #@y"
end

def dec01_p01
	max_sum = 0
	current_sum = 0
	IO.foreach($base_folder + "dec01_p01.txt"){ |line|
		if line == "\n"
			if current_sum > max_sum
				max_sum = current_sum
			end
			current_sum = 0
		else
			current_sum = current_sum + line.to_i
		end
	}
	puts max_sum
end

def argmin(array)
	argmin = 0
	min_v = array[0]
	for i in 0..array.length-1
		if array[i] < min_v
			argmin = i
			min_v = array[i]
		end
	end
	return argmin
end

def update_maxes(max_values, new_max)
	if new_max > max_values.min
		max_values[argmin max_values] = new_max
	end
end

def dec01_p02
	max_three_sums = [0, 0, 0]
	current_sum = 0
	IO.foreach($base_folder + "dec01_p01.txt"){ |line|
		if line == "\n"
			update_maxes max_three_sums, current_sum
			current_sum = 0
		else
			current_sum = current_sum + line.to_i
		end
	}
	puts max_three_sums.sum
end

dec01_p01
dec01_p02
