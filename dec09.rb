require 'pp'

require_relative 'common'
include Common

class Bridge
    

    def initialize(file_path)
        x, y = 0, 0
        IO.foreach(file_path){ |line|
            direction, steps = line.strip().split()
            
        }
    end

    def 
end

def dec09p01
    bridge = Bridge.new($base_folder + "dec09.txt")
    
end