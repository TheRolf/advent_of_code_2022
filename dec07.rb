
require 'pp'

require_relative 'common'
include Common

class FileSystemObject
    def initialize(name, parent)
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
    def initialize(name, parent)
        super
        @children = []
    end

    def add_child(object)
        @children.append(object)
    end

    def get_children()
        return @children
    end

    def get_size()
        s = 0
        @children.each{ |child|
            s += child.get_size
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
        super(name, parent)
        @size = size
    end

    def get_size()
        return @size
    end
end

def sum_smaller_than(folder, siz)
    s = 0
    folder_size = folder.get_size
    if folder_size < siz
        s += folder_size
    end
    folder.get_children.each{ |object|
        if object.class == Folder
            s += sum_smaller_than(object, siz)
        end
    }
    return s
end

def to_delete(folder, siz)
    min_k = ""
    min_v = Float::INFINITY
    folder.get_children.each{ |object|
        if object.class == Folder
            key, value = to_delete(object, siz)
            if value >= siz and value < min_v
                min_k, min_v = key, value
            end
        end
    }
    folder_size = folder.get_size
    print folder.get_name, " ", folder_size
    puts
    if folder_size >= siz and folder_size < min_v
        return folder.get_name, folder_size
    else
        return min_k, min_v
    end
end

def dec07_p01
    root = Folder.new("/", nil)
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
            Folder.new(sline[1], pwd)
        else
            Fajl.new(sline[1], sline[0].to_i, pwd)
        end       
    }

    pp root.get_size

    pp sum_smaller_than(root, 100000)

    pp to_delete(root, 8381165)
end

dec07_p01