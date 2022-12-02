require_relative 'common'
include Common


def dec02_p01
    pts_shape = {"X" => 1, "Y" => 2, "Z" => 3}
    pts_round = {["A", "X"] => 3, ["B", "Y"] => 3, ["C", "Z"] => 3,
                 ["A", "Y"] => 6, ["B", "Z"] => 6, ["C", "X"] => 6,
                 ["A", "Z"] => 0, ["B", "X"] => 0, ["C", "Y"] => 0}
    points = 0
    IO.foreach($base_folder + "dec02_p01.txt"){ |line|
        elf, you = line.split(" ")
        points += pts_round[[elf, you]]
        points += pts_shape[you]
    }
    return points
end

def dec02_p02
    pts_shape = {"A" => 1, "B" => 2, "C" => 3}
    pts_round = {"X" => 0, "Y" => 3, "Z" => 6}
    
    to_draw = {"A" => "A", "B" => "B", "C" => "C"}
    to_win = {"A" => "B", "B" => "C", "C" => "A"}
    to_lose = {"A" => "C", "B" => "A", "C" => "B"}
    shapes = {"X" => to_lose, "Y" => to_draw, "Z" => to_win}
    
    points = 0
    IO.foreach($base_folder + "dec02_p01.txt"){ |line|
        elf, strategy = line.split(" ")
        points += pts_shape[ shapes[strategy][elf] ]
        points += pts_round[strategy]
    }
    return points
end

result = dec02_p01
puts result

result = dec02_p02
puts result

