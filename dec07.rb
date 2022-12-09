
require 'pp'

require_relative 'common'
include Common

def dec07_p01
    pwd = "/"
    tree = {pwd => {}}
    pp tree
    IO.foreach($base_folder + "dec07.txt"){ |line|
        sline = line.split()
        if sline[0] == "$"
            if sline[1] == "cd"
                           
            end
        end       
    }
end

def total_size(object)
    if object.class == Integer
        return object
    elsif object.class == Hash
        size = 0
        object.each{ |child, attribute|
            size += total_size(attribute)
        }
        return size
    else
        p "Invalid type"
    end
end

tree = {"/" => {
            "cwdpn" => {
                "mnm" => {"file1" => 456, "file2" => 320},
                "nmsvc" => {},
                "rgbdq" => {}
                },
            "drzllllv" => {"file324" => 776},
            "fqflwvh" => {},
            "jczm" => {"file444" => 444},
            "asdfile" => 1345
            }
        }

pp tree
puts
tree["/"].each{ |object, value|
    print object, value
    puts
}

puts
p total_size(tree)

puts
dec07_p01
