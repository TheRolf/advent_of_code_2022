require 'pp'


class Monkeys
    def initialize
        @n = 8
        # @n = 4

        @item_lists = Array.new(@n){ Queue.new }
        @number_of_inspects = Array.new(@n){ 0 }
        
        @item_lists[0] << 65 << 58 << 93 << 57 << 66
        # @item_lists[0] << 79 << 98
        @item_lists[1] << 76 << 97 << 58 << 72 << 57 << 92 << 82
        # @item_lists[1] << 54 << 65 << 75 << 74
        @item_lists[2] << 90 << 89 << 96
        # @item_lists[2] << 79 << 60 << 97
        @item_lists[3] << 72 << 63 << 72 << 99
        # @item_lists[3] << 74

        @item_lists[4] << 65
        @item_lists[5] << 97 << 71
        @item_lists[6] << 83 << 68 << 88 << 55 << 87 << 67
        @item_lists[7] << 64 << 81 << 50 << 96 << 82 << 53 << 62 << 92

        @test_mod = [19, 3, 13, 17, 2, 11, 5, 7]
        # @test_mod = [23, 19, 13, 17]
        @test_true = [6, 7, 5, 0, 6, 7, 2, 3]
        # @test_true = [2, 2, 1, 0]
        @test_false = [4, 5, 1, 4, 2, 3, 1, 0]
        # @test_false = [3, 0, 3, 1]
    end

    def operation(monkey, item)
        case monkey
        when 0
            return item * 7
            # return item * 19
        when 1
            return item + 4
            # return item + 6
        when 2
            return item * 5
            # return item * item
        when 3
            return item * item
            # return item + 3

        when 4
            return item + 1
        when 5
            return item + 8
        when 6
            return item + 2
        when 7
            return item + 5
        end
    end

    def process(monkey)
        item_list = @item_lists[monkey]
        until item_list.empty?
            @number_of_inspects[monkey] += 1
            item = item_list.pop()
            item = operation(monkey, item)
            # item = item / 3
            if item % @test_mod[monkey] == 0
                to_monkey = @test_true[monkey]
            else
                to_monkey = @test_false[monkey]
            end
            # print "Puts ", item, " from ", monkey, " to ", to_monkey
            # puts
            @item_lists[to_monkey].push(item % (19*3*13*17*2*11*5*7))
        end
    end

    def round()
        for i in 0..@n-1
            process(i)
        end
    end

    def pprint(monkey)
        print monkey, ": "
        item_list = @item_lists[monkey]
        new_list = Queue.new
        until item_list.empty?
            item = item_list.pop()
            print item, " "
            new_list << item
        end
        puts
        @item_lists[monkey] = new_list
    end

    def show()
        for i in 0..@n-1
            pprint(i)
        end
        pp @number_of_inspects
    end
end

m = Monkeys.new

m.show()
puts

for j in 1..20
    m.round()
end

m.show()
puts

m = Monkeys.new

for j in 1..10000
    m.round()
end

m.show()
