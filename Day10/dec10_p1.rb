require 'pp'


def signal_strength(i, x)
    if [20, 60, 100, 140, 180, 220].include? i.to_i
        pp [i, x, i*x]
        return i*x
    else
        return 0
    end    
end

def dec10p01
    x = 1
    i = 1
    total_signal_strength = 0
    lines =  File.readlines(__dir__ + "/dec10.txt")
    lines.each{ |line|
        line = line.strip()
        sline = line.split(" ")
        if sline[0] == "noop"
            pp [i, x, line]
            total_signal_strength = total_signal_strength + signal_strength(i, x)
            i = i+1
        elsif sline[0] == "addx"
            pp [i, x, line]
            total_signal_strength = total_signal_strength + signal_strength(i, x)
            i = i+1
            pp [i, x, line]
            total_signal_strength = total_signal_strength + signal_strength(i, x)
            i = i+1
            x = x + sline[1].to_i
        end
    }
    puts total_signal_strength
end

dec10p01