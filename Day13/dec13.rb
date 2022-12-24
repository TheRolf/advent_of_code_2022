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

def dec13
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

dec13
