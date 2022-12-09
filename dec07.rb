
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

puts
dec07_p01


class Folder
    def initialize(name, parent)
        @name = name
        @children = []
        @parent = parent
        if @parent != nil
            @parent.add_child(self)
        end
    end

    def add_child(object)
        @children.append(object)
    end

    def size()
        s = 0
        @children.each{ |child|
            s += child.size
        }
        return s
    end
end

class File
    def initialize(name, size, parent)
        @name = name
        @size = size
        @parent = parent
        if @parent != nil
            @parent.add_child(self)
        end
    end

    def size()
        return @size
    end
end


root = Folder.new("/", nil)
folder1 = Folder.new("folder1", root)
file1 = File.new("file1", 456, root)
file2 = File.new("file2", 100, folder1)
pp root
pp root.size
puts
pp folder1
# pp folder1.size
