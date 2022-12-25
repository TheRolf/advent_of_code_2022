require 'pp'
require 'set'

class Coord
	def initialize(x, y)
		@x, @y = x.to_i, y.to_i
	end
	
	attr_accessor :x, :y
end

class Cave
	def initialize(part)
		@objects = Set[]
		@numberof_sand_drops = 0
		@lowest_rock_line = 0
		@part = part
	end
	
	def add_rock_polyline(line)
		sline = line.strip().split(" -> ")
		p1x, p1y = sline[0].split(",")
		if p1y.to_i > @lowest_rock_line
			@lowest_rock_line = p1y.to_i
		end
		for i in 1..sline.size-1
			p2x, p2y = sline[i].split(",")
			add_rock_line(Coord.new(p1x, p1y), Coord.new(p2x, p2y))
			p1x, p1y = p2x, p2y
			if p1y.to_i > @lowest_rock_line
				@lowest_rock_line = p1y.to_i
			end
		end
	end
	
	def add_rock_line(p1, p2)
		if p1.x == p2.x
			min_y, max_y = [p1.y, p2.y].min, [p1.y, p2.y].max
			for y_ in min_y..max_y
				@objects.add([p1.x, y_])
			end
		elsif p1.y == p2.y
			min_x, max_x = [p1.x, p2.x].min, [p1.x, p2.x].max
			for x_ in min_x..max_x
				@objects.add([x_, p1.y])
			end
		else
			pp "ERROR"
		end
	end
	
	def sand_move(coords)
		if coords.y == @lowest_rock_line+1 and @part == 2
			@objects.add([coords.x, coords.y])
			return false
		elsif not @objects.include? [coords.x, coords.y+1]
			coords.y += 1
			return true
		elsif not @objects.include? [coords.x-1, coords.y+1]
			coords.x -= 1
			coords.y += 1
			return true
		elsif not @objects.include? [coords.x+1, coords.y+1]
			coords.x += 1
			coords.y += 1
			return true
		else
			@objects.add([coords.x, coords.y])
			return false
		end			
	end
	
	def sand_drop()
		sand = Coord.new(500, 0)
		while sand.y <= 1000 and sand_move(sand)
		end
		
		if sand.y < 1000 and sand.y > 0
			@numberof_sand_drops += 1
			return true
		else
			return false
		end
	end
	
	attr_accessor :objects
end

def dec14(part)
	cave = Cave.new(part)
	lines =  File.readlines(__dir__ + "/dec14.txt")
    lines.each{ |line|
		cave.add_rock_polyline(line)
	}
	original_size = cave.objects.size
	while cave.sand_drop()
	end
	pp cave.objects.size - original_size
end

dec14(1)
dec14(2)
