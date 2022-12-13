require 'pp'
require 'set'


class Rope
    def initialize(file_path)
        @head_x, @head_y = 0, 0
        @tail_x, @tail_y = 0, 0
        @tail_visited = Set[]
        @file_path = file_path
    end

    def walk()
        coeff = {"U" => [0, 1], "D" => [0, -1], "R" => [1, 0], "L" => [-1, 0]}
        IO.foreach(@file_path){ |line|
            # pp line.strip()
            sline = line.strip().split()
            direction, steps = sline[0], sline[1].to_i
            for i in (0..steps-1)
                head_step(coeff[direction][0], coeff[direction][1])
                # pp ["H", @head_x, @head_y]
                tail_step()
                # pp ["T", @tail_x, @tail_y]
            end
        }
    end

    def head_step(new_x, new_y)
        @head_x = @head_x + new_x
        @head_y = @head_y + new_y
    end

    def tail_step()
        
        if (@head_y - @tail_y).abs >= 2
            if @head_x != @tail_x
                @tail_x = @head_x
            end
            @tail_y = @head_y > @tail_y ? @tail_y+1 : @tail_y-1
        end
        
        if (@head_x - @tail_x).abs >= 2
            if @head_y != @tail_y
                @tail_y = @head_y
            end
            @tail_x = @head_x > @tail_x ? @tail_x+1 : @tail_x-1
        end

        @tail_visited.add([@tail_x, @tail_y])
    end

    def get_tail_visited
        return @tail_visited
    end

end

def dec09p01
    rope = Rope.new(__dir__ + "/dec09.txt")
    rope.walk()
    pp rope.get_tail_visited.size
end

dec09p01