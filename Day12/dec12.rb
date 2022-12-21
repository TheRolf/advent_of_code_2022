require 'pp'

class Cell
    def initialize(height)
        @height = height
        @left, @right, @top, @bottom = nil, nil, nil, nil
    end

    def set_neighbors(left, right, top, bottom)
        @left, @right, @top, @bottom = left, right, top, bottom
    end

    def get_height()
        return @height
    end

end


class Map
    def initialize(matrix)
        @height, @width = matrix.size, matrix[0].size
        @cells = Array.new(@height){ Array.new(@width){ 0 } }
        for i in 0..@height-1
            for j in 0..@width-1
                @cells[i][j] = Cell.new(matrix[i][j])
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
                print @cells[i][j].get_height 
            end
            puts
        end
    end
end

def dec12p01
    matrix = []
    lines =  File.readlines(__dir__ + "/dec12_small.txt")
    lines.each{ |line|
        row = line.strip().split("")
        matrix << row
    }
    pp matrix

    m = Map.new(matrix)
    m.pprint()
end

dec12p01