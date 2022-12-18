require 'pp'


def read_grid
    grid = []
    lines =  File.readlines(__dir__ + "/dec08.txt")
    lines.each{ |line|
        grid << line.strip().split("").map{|x| x.to_i}
    }
    return grid
end

def visible(grid, i, j)
    tree_height = grid[i][j]
    vis_l, vis_r, vis_t, vis_b = true, true, true, true
    for i0 in (0..i-1)
        if grid[i0][j] >= tree_height
            vis_t = false
            break
        end
    end
    for i0 in (i+1..grid.size-1)
        if grid[i0][j] >= tree_height
            vis_b = false
            break
        end
    end
    for j0 in (0..j-1)
        if grid[i][j0] >= tree_height
            vis_l = false
            break
        end
    end
    for j0 in (j+1..grid.size-1)
        if grid[i][j0] >= tree_height
            vis_r = false
            break
        end
    end
    return (vis_l or vis_r or vis_t or vis_b)
end

def number_of_visible(grid)
    n_visible = 0
    for i in (0..grid.size-1)
        for j in (0..grid[0].size-1)
            if visible(grid, i, j)
                n_visible += 1
            end
        end
    end
    return n_visible
end

def scenic_score(grid, i, j)
    tree_height = grid[i][j]
    vis_l, vis_r, vis_t, vis_b = 0, 0, 0, 0
    for i0 in (i-1..0).step(-1)
        vis_t += 1 
        if grid[i0][j] >= tree_height
            break
        end
    end
    for i0 in (i+1..grid.size-1)
        vis_b += 1
        if grid[i0][j] >= tree_height
            break
        end
    end
    for j0 in (j-1..0).step(-1)
        vis_l += 1
        if grid[i][j0] >= tree_height
            break
        end
    end
    for j0 in (j+1..grid.size-1)
        vis_r += 1        
        if grid[i][j0] >= tree_height
            break
        end
    end
    # pp [vis_l, vis_r, vis_t, vis_b]
    return (vis_l * vis_r * vis_t * vis_b)
end

def highest_scenic_score(grid)
    max_k, max_v = [0, 0], 0
    for i in (0..grid.size-1)
        for j in (0..grid[0].size-1)
            scenic_score_tree = scenic_score(grid, i, j)
            # pp [grid[i][j], [i, j], scenic_score_tree]
            if scenic_score_tree > max_v
                max_k, max_v = [i, j], scenic_score_tree
            end
        end
    end
    return max_k, max_v
end

def dec08_p01
    grid = read_grid()
    pp number_of_visible(grid)
end

def dec08_p02
    grid = read_grid()
    pp highest_scenic_score(grid)
end


a = [[3, 0, 3, 7, 3],
     [2, 5, 5, 1, 2],
     [6, 5, 3, 3, 2],
     [3, 3, 5, 4, 9],
     [3, 5, 3, 9, 0]]

pp a
pp number_of_visible(a)
puts
pp highest_scenic_score(a)

puts

dec08_p01
dec08_p02
