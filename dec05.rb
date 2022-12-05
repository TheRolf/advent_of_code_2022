require_relative 'common'
include Common

def read_crates
    crate_stacks = Array.new(9){ [] }
    IO.foreach($base_folder + "dec05.txt"){ |line|
        if line.strip == ""
            return
        end

    }
end

