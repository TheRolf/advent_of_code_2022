require_relative 'common'
include Common

def read_crates
    crate_stacks = Array.new(9){ [] }
    IO.foreach($base_folder + "dec05.txt"){ |line|
        if line[0] != " "
            for i in (0..8)
                if line[1+4*i] != " "
                    crate_stacks[i].prepend(line[1+4*i])
                end
            end
        else
            return crate_stacks
        end
    }
end

def print_crates(crate_stacks)
    max_length = crate_stacks.map{|stack| stack.size}.max
    puts
    for k in (max_length-1..0).step(-1)
        for i in (0..8)
            if k < crate_stacks[i].size
                print "[", crate_stacks[i][k], "] "
            else
                print "    "
            end
        end
        puts
    end
    for i in (1..9)
        print " ", i, "  "
    end
    puts
end

def dec04_p01
    crate_stacks = read_crates
    read = false
    IO.foreach($base_folder + "dec05.txt"){ |line|
        if line.strip == ""
            read = true
        elsif read
            sline = line.split()
            k, from, to = [sline[1], sline[3], sline[5]].map{|x| x.to_i}
            for i in (1..k)
                crate_stacks[to-1] << crate_stacks[from-1].pop
            end
        end
    }
    for i in (0..8)
        print crate_stacks[i][-1]
    end
    puts
end

def dec04_p02
    crate_stacks = read_crates
    read = false
    IO.foreach($base_folder + "dec05.txt"){ |line|
        if line.strip == ""
            read = true
        elsif read
            sline = line.split()
            k, from, to = [sline[1], sline[3], sline[5]].map{|x| x.to_i}
            p crate_stacks[from-1][-k..-1]
            puts
            crate_stacks[to-1] += crate_stacks[from-1][-k..-1]
            crate_stacks[from-1] = crate_stacks[from-1][..-k-1]
            print_crates crate_stacks
        end
    }
    for i in (0..8)
        print crate_stacks[i][-1]
    end
    puts
end

# crate_stacks = read_crates
# for i in (0..8)
#     print crate_stacks[i]
#     puts
# end

# print_crates(crate_stacks)


dec04_p01

a = [2, 3]
a += [7, 6]
p a

dec04_p02
