require 'pp'
require 'set'

require_relative 'common'
include Common

class Knot
    def initialize()
        @x, @y = 0, 0
    end
    attr_accessor :x, :y
end

class RopeOnSteroids
    def initialize(file_path, no_knots=2)
        @no_knots = no_knots
        @knots = Array.new(@no_knots) { Knot.new() }
        @tail_visited = Set[]
        @file_path = file_path
    end

    def walk()
        coeff = {"U" => [0, 1], "D" => [0, -1], "R" => [1, 0], "L" => [-1, 0]}
        IO.foreach(@file_path){ |line|
            pp line.strip()
            sline = line.strip().split()
            direction, steps = sline[0], sline[1].to_i
            for i in (0..steps-1)
                head_step(coeff[direction][0], coeff[direction][1])
                pp ["H", @knots[0].x, @knots[0].y]
                for k in (1..@no_knots-1)
                    knots_step(k)
                end
                @tail_visited.add([@knots[-1].x, @knots[-1].y])
                pp ["T", @knots[@no_knots-1].x, @knots[@no_knots-1].y]
            end
        }
    end

    def head_step(new_x, new_y)
        @knots[0].x = @knots[0].x + new_x
        @knots[0].y = @knots[0].y + new_y
    end

    def knots_step(k)
        if (@knots[k-1].y - @knots[k].y).abs >= 2
            if @knots[k-1].x != @knots[k].x
                @knots[k].x = @knots[k-1].x
            end
            @knots[k].y = @knots[k-1].y > @knots[k].y ? @knots[k].y+1 : @knots[k].y-1
        end
        
        if (@knots[k-1].x - @knots[k].x).abs >= 2
            if @knots[k-1].y != @knots[k].y
                @knots[k].y = @knots[k-1].y
            end
            @knots[k].x = @knots[k-1].x > @knots[k].x ? @knots[k].x+1 : @knots[k].x-1
        end
    end

    def get_tail_visited
        return @tail_visited
    end

end

def dec09p02
    rope = RopeOnSteroids.new($base_folder + "dec09_p2_small.txt", 10)
    rope.walk()
    pp rope.get_tail_visited.size
end

dec09p02