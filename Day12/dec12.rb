require 'pp'

class Cell
    def initialize(height, i, j)
        @height = height
        @distance = Float::INFINITY
        @left, @right, @top, @bottom = nil, nil, nil, nil
        @text = i.to_s + "," + j.to_s
    end

    attr_reader :text

    def set_neighbors(left, right, top, bottom)
        @left, @right, @top, @bottom = left, right, top, bottom
    end

    def get_height()
        return @height
    end

    def get_result()
        return @distance
    end

    def set_dist(value)
        @distance = value
    end

    def compute()
        for neighbor in [@left, @right, @top, @bottom]
            if neighbor != nil and neighbor.get_result + 1 < @distance and neighbor.get_height <= @height + 1
                @distance = neighbor.get_result + 1
            end
        end
    end

end


class Map
    def initialize(matrix)
        @height, @width = matrix.size, matrix[0].size
        @cells = Array.new(@height){ Array.new(@width){ 0 } }
        @distance = Array.new(@height){ Array.new(@width){ -1 } }
        @start_pos = nil
        @end_pos = nil
        
        for i in 0..@height-1
            for j in 0..@width-1
                if matrix[i][j] == "S"
                    @cells[i][j] = Cell.new("a".ord, i, j)
                    @start_pos = @cells[i][j]
                elsif matrix[i][j] == "E"
                    @cells[i][j] = Cell.new("z".ord, i, j)
                    @end_pos = @cells[i][j]
                else
                    @cells[i][j] = Cell.new(matrix[i][j].ord, i, j)
                end
            end
        end
        set_neighbors()
    end

    def set_neighbors()
        for i in 0..@height-1
            for j in 0..@width-1
                top = i==0 ? nil : @cells[i-1][j]
                bottom = i==@height-1 ? nil : @cells[i+1][j]
                left = j==0 ? nil : @cells[i][j-1]
                right = j==@width-1 ? nil : @cells[i][j+1]
                @cells[i][j].set_neighbors(left, right, top, bottom)
            end
        end
    end

    def pprint()
        for i in 0..@height-1
            for j in 0..@width-1
                res = @cells[i][j].get_height.to_s.rjust(3)
                if @cells[i][j] == @start_pos
                    print ".", res, "." 
                elsif @cells[i][j] == @end_pos
                    print "[", res, "]" 
                else
                    print " ", res, " " 
                end
            end
            puts
        end
    end

    def print_result_table()
        for i in 0..@height-1
            for j in 0..@width-1
                res = @cells[i][j].get_result.to_s.rjust(2)
                if @cells[i][j] == @start_pos
                    print ".", res, "." 
                elsif @cells[i][j] == @end_pos
                    print "[", res, "]" 
                else
                    print " ", res, " " 
                end
            end
            puts
        end
    end

    def dyn_prog()
        @end_pos.set_dist(0)
        for k in 1..([@height, @width].max*[@height, @width].max)
            for i in 0..@height-1
                for j in 0..@width-1
                    @cells[i][j].compute()
                end
            end
        end
    end

    def get_result_p1()
        return @start_pos.get_result()
    end

    def get_result_p2()
        shortest = Float::INFINITY
        for i in 0..@height-1
            for j in 0..@width-1
                cell = @cells[i][j]
                if cell.get_height == 97 and cell.get_result < shortest
                    shortest = cell.get_result
                end
            end
        end
        return shortest
    end
end



def dec12
    matrix = []
    lines =  File.readlines(__dir__ + "/dec12.txt")
    lines.each{ |line|
        row = line.strip().split("")
        matrix << row
    }
    # pp matrix

    m = Map.new(matrix)
    # m.pprint

    # m.print_result_table()

    m.dyn_prog()
    # m.print_result_table()
    pp m.get_result_p1()

    pp m.get_result_p2()
end

dec12

# for i, j in [[0, 0], [1, 2]]
#     pp [i, j]
# end

