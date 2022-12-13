def all_different(chars)
    for i in (0..chars.size-1)
        for j in (i+1..chars.size-1)
            if chars[i] == chars[j]
                return false
            end
        end
    end
    return true
end

def find_marker(chars, len)
    i = 0
    while chars[i+len-1] != "\n"
        if all_different(chars[i..i+len-1])
            p i+len
            return
        end
        i += 1
    end
    p "No marker"
end

def dec06_p01
    data = File.read(__dir__ + "/dec06.txt")
    find_marker(data, 4)
end

def dec06_p02
    data = File.read(__dir__ + "/dec06.txt")
    find_marker(data, 14)
end


dec06_p01
dec06_p02
find_marker "mjqjpqmgbljsphdztnvjfqwrcgsmlb", 4
