
require 'pp'

require_relative 'common'
include Common

class FileSystemObject
    def initialize(name, size, parent)
        @name = name
        @parent = parent
        if @parent != nil
            @parent.add_child(self)
        end
    end

    def get_name()
        return @name
    end

    def get_parent()
        return @parent
    end
end

class Folder < FileSystemObject
    def initialize(name, size, parent)
        super
        @children = []
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

    def get_child(name)
        @children.each{ |child|
            if child.get_name == name
                return child
            end
        }
        return nil
    end
end

class Fajl < FileSystemObject
    def initialize(name, size, parent)
        super
        @size = size
    end
    
    def size()
        return @size
    end
end


root = Folder.new("/", 0, nil)
folder1 = Folder.new("folder1", 0, root)
file1 = Fajl.new("file1", 456, root)
file2 = Fajl.new("file2", 100, folder1)

pp root.get_child("file1")

def dec07_p01
    root = Folder.new("/", 0, nil)
    pwd = root
    IO.foreach($base_folder + "dec07.txt"){ |line|
        sline = line.split()
        if sline[0] == "$"
            if sline[1] == "cd"
                if sline[2] == ".."
                    pwd = pwd.get_parent()
                elsif sline[2] != "/"
                    pwd = pwd.get_child(sline[2])
                end
            end
        elsif sline[0] == "dir"
            Folder.new(sline[1], 0, pwd)
        else
            Fajl.new(sline[1], sline[0].to_i, pwd)
        end       
    }
    pp root
    pp root.size
end

# dec07_p01