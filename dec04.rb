require_relative 'common'
include Common

def fully_contains(range1, range2)
    if range1[0] <= range2[0] and range1[1] >= range2[1]
        return true
    elsif range1[0] >= range2[0] and range1[1] <= range2[1]
        return true
    else
        return false
    end
end

def overlaps(range1, range2)
    if range1[0].between?(range2[0], range2[1]) or range2[0].between?(range1[0], range1[1])
        return true
    else
        return false
    end
end

def dec04_p01
    total_value = 0
    IO.foreach($base_folder + "dec04.txt"){ |line|
        ranges = line.strip.split(",")
        elf1, elf2 = ranges[0].split("-"), ranges[1].split("-")
        elf1, elf2 = [elf1, elf2].map{|elf| elf.map{|x| x.to_i} }
        if fully_contains(elf1, elf2)
            total_value += 1
        end
    }
    return total_value
end

def dec04_p02
    total_value = 0
    IO.foreach($base_folder + "dec04.txt"){ |line|
        ranges = line.strip.split(",")
        elf1, elf2 = ranges[0].split("-"), ranges[1].split("-")
        elf1, elf2 = [elf1, elf2].map{|elf| elf.map{|x| x.to_i} }
        if overlaps(elf1, elf2)
            total_value += 1
        end
    }
    return total_value
end

p dec04_p01
p dec04_p02