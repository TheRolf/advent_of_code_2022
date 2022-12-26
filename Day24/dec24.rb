require 'pp'

class Blizzard
	
	def initialize(x, y, d)
		@x, @y, @d = x, y, d
		@width, @height = 0, 0
	end
	attr_accessor :x, :y, :d
	
	def step
		case @d
		when "<"
			@y = (@y-1) % @width
		when ">"
			@y = (@y+1) % @width
		when "^"
			@x = (@x-1) % @height
		when "v"
			@x = (@x+1) % @height
		end
	end
	
	def set_dim(width, height)
		@width, @height = width, height
	end
end


class Valley
	def initialize
		@blizzards = []
		@height, @width = 0, 0
		@matrix = nil
		@time = 0
		@px, @py = -1, 0
	end
	
	def add(line)
		line = line.strip.gsub("#", "")
		if line.size > 1
			@width = line.size
			line.split("").each_with_index{|value, index| 
				if value != "."
					@blizzards << Blizzard.new(@height, index, value)
				end
			}
			@height += 1
		end
	end
	
	def build
		@blizzards.each{ |blizzard| blizzard.set_dim(@width, @height)}
		build_matrix()
	end
	
	def step
		@blizzards.each{ |blizzard| blizzard.step()}
		@time += 1
		build_matrix()
		
		if [@px, @py] == [@height-1, @width-1]
			return false
		end
		
		steps = [[@px, @py], [@px-1, @py], [@px+1, @py], [@px, @py-1], [@px, @py+1]]
		possible = []
		steps.each{ |x, y|
			if x.between?(0, @height) and y.between?(0, @width) and @matrix[x][y] == "."
				possible << [x, y]
			end
		}
		pp possible
		if possible.size == 1
			@px, @py = possible[0]
			return true
		else
			return false
		end
	end
	
	def build_matrix
		@matrix = Array.new(@height){ Array.new(@width){"."} }
		@blizzards.each{ |blizzard|
			x, y = blizzard.x, blizzard.y
			if @matrix[x][y].class == Integer
				@matrix[x][y] += 1
			elsif @matrix[x][y] == "."
				@matrix[x][y] = blizzard.d
			else
				@matrix[x][y] = 2
			end
		}
		if @px >= 0
			@matrix[@px][@py] = "P"
		end
	end
	
	def draw
		puts @time
		puts Array.new(@width+2){"#"}.join("")
		for x in 0..@height-1
			puts @matrix[x].unshift("#").append("#").join("")
		end
		puts Array.new(@width+2){"#"}.join("")
		puts
	end
end

def dec24_p1
	lines =  File.readlines(__dir__ + "/dec24_small.txt")
	valley = Valley.new()
    lines.each{ |line|
		valley.add(line)
	}
	valley.build()
	valley.draw()
	while valley.step()
		valley.draw()
	end
	valley.draw()
end

dec24_p1

	