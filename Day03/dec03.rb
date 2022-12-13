require 'set'


def string_to_set(str)
    set = Set[]
    str.each_char{ |c|
        set.add(c)
    }
    return set
end

def value(char)
    if char.ord.between?(65, 90) 
        return char.ord - 38
    elsif char.ord.between?(97, 122)
        return char.ord - 96
    end
end

def dec03_p01
    total_value = 0
    IO.foreach(__dir__ + "/dec03.txt"){ |line|
        line = line.strip
        line1, line2 = line[0..line.length/2-1], line[line.length/2, line.length-1]
        pocket1, pocket2 = string_to_set(line1), string_to_set(line2)
        common_elem = (pocket1 & pocket2).to_a[0]
        total_value += value(common_elem)
    }
    return total_value
end

def dec03_p02
    total_value = 0
    group = []
    IO.foreach(__dir__ + "/dec03.txt"){ |line|
        group << string_to_set(line.strip)
        if group.length == 3
            common_elem = (group[0] & group[1] & group[2]).to_a[0]
            total_value += value(common_elem)
            group = []
        end
    }
    return total_value
end


puts dec03_p01
puts dec03_p02

