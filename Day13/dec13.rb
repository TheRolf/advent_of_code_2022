require 'pp'
require 'json'

def correct_order_scalars(left, right)
    if left > right
        return false
    end
    return true
end

def correct_order_arrays(left, right)
    if left.size > right.size
        return false
    end
    for i in 0..left.size-1
        if !correct_order(left[i], right[i])
            return false
        end
    end
end

def correct_order(left, right)
    if left.class == Integer && right.class == Integer
        if !correct_order_scalars(left, right)
            return false
        end
    elsif left.class == Array && right.class == Array
        if !correct_order_arrays(left, right)
            return false
        end
    else
        if left.class == Integer
            left = [left]
        else
            right = [right]
        end
        if !correct_order_arrays(left, right)
            return false
        end
    end
    return true
end

def dec13
    i = 1
    indices_right_order = []
    left, right = "", ""
    lines =  File.readlines(__dir__ + "/dec13_small.txt")
    lines.each{ |line|
        if i%3 == 1
            left = JSON.parse(line)
        elsif i%3 == 2
            right = JSON.parse(line)
        else
            pp [left, right, correct_order(left, right)]

            if correct_order(left, right)
                indices_right_order << (i/3 + 1)
            end
        end
        i += 1
    }
end

dec13