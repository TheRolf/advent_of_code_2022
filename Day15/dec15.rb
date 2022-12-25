require 'pp'
require 'set'

class BeaconMap
	def initialize
		@sensors = []
		@no_distress = Set[]
		@x_min, @x_max, @y_min, @y_max = Float::INFINITY, -Float::INFINITY, Float::INFINITY, -Float::INFINITY
		@dist_max = 0
		@exc_min, @exc_max = 0, 0
	end
	attr_accessor :x_min, :x_max, :y_min, :y_max, :dist_max
	
	def add(sensor)
		@sensors << sensor
		@x_min = [@x_min, sensor.x, sensor.b_x].min
		@x_max = [@x_max, sensor.x, sensor.b_x].max
		@y_min = [@y_min, sensor.y, sensor.b_y].min
		@y_max = [@y_max, sensor.y, sensor.b_y].max
		@dist_max = [@dist_max, sensor.dist_closest].max
		@exc_min = @x_min-@dist_max
		@exc_max = @x_max-@dist_max
	end
	
	def exclude_distress(row, x_min=nil, x_max=nil)
		n_cells = 0
		x_min = x_min ? x_min : @exc_min
		x_max = x_max ? x_max : @exc_max
		for x in x_min..x_max
			x_ok = true
			@sensors.each{ |sensor|
			if sensor.dist(x, row) <= sensor.dist_closest # and [x, row] != [sensor.b_x, sensor.b_y]
				#n_cells += 1
				x_ok = false
				break
			end
			}
			if x_ok
				pp [x, row]
			end
		end
		return n_cells
	end
	
end

class Sensor
	def initialize(line)
		strings = [[], [], [], []]
		i = 0
		write = false
		line.split("").each{ |c|
			if c == "="
				write = true
			elsif c == "," or c == ":" or c == "\n"
				write = false
				i += 1
			elsif write
				strings[i] << c
			end
		}
		@x, @y, @b_x, @b_y = strings.map{|s| s.join.to_i}
		@dist_closest = (@x-@b_x).abs + (@y-@b_y).abs
	end
	attr_accessor :x, :y, :b_x, :b_y, :dist_closest
	
	def dist(x, y)
		return (@x-x).abs + (@y-y).abs
	end
	
end

def dec15_p1
	lines =  File.readlines(__dir__ + "/dec15.txt")
	map = BeaconMap.new()
    lines.each{ |line|
		sensor = Sensor.new(line)
		#puts sensor.dist_closest()
		map.add(sensor)
	}
	pp [map.x_min, map.x_max, map.y_min, map.y_max]
	pp map.dist_max
	for i in ([0, map.y_min].max)..([4000000, map.y_max].min)
		t = Time.now
		print i, " "
		STDOUT.flush
		map.exclude_distress(i, [0, map.y_min].max, [4000000, map.y_max].min)
		print Time.now-t, "\n"
	end
	# pp map.exclude_distress(10, 0, 20)
	
end

dec15_p1