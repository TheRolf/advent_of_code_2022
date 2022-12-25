require 'pp'
require 'json'

def correct_order_scalars(left, right)
    if left > right
        return -1
    elsif left < right
		return 1
	else
		return 0
	end
end

def correct_order_arrays(left, right)

    for i in 0..[left.size-1, right.size-1].min
		order = correct_order(left[i], right[i])
        if order != 0
            return order
        end
    end
	if left.size > right.size
        return -1
	elsif left.size < right.size
		return 1
	else
		return 0
    end
end

def correct_order(left, right)
    if left.class == Integer && right.class == Integer
        return correct_order_scalars(left, right)
    elsif left.class == Array && right.class == Array
        return correct_order_arrays(left, right)
    else
        if left.class == Integer
            left = [left]
        else
            right = [right]
        end
        return correct_order_arrays(left, right)
    end
end

def dec13_p01
    i = 1
    indices_right_order = []
    left, right = "", ""
    lines =  File.readlines(__dir__ + "/dec13.txt")
    lines.each{ |line|
        if i%3 == 1
            left = JSON.parse(line)
        elsif i%3 == 2
            right = JSON.parse(line)
        else
            #pp [left, right, correct_order(left, right)]

            if correct_order(left, right) == 1
                indices_right_order << (i/3)
            end
        end
        i += 1
	}
	#pp [left, right, correct_order(left, right)]

	if correct_order(left, right) == 1
		indices_right_order << (i/3)
	end
    
	pp indices_right_order
	pp indices_right_order.sum
	
end

def dec13_p02
   
    packets = [[[2]], [[6]]]
    left, right = "", ""
    lines =  File.readlines(__dir__ + "/dec13.txt")
    lines.each{ |line|
        if line.strip() != ""
			packets << JSON.parse(line)
		end	
	}
	for i in 0..packets.size-1
		for j in i+1..packets.size-1
			if correct_order(packets[i], packets[j]) == -1
				packets[i], packets[j] = packets[j], packets[i]
			end
		end
	end
	#pp packets
	for i in 0..packets.size-1
		if packets[i] == [[2]] || packets[i] == [[6]]
			pp i+1
		end
	end
end

#dec13_p01

dec13_p02
