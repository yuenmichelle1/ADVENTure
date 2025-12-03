input = File.read('./day2_input.txt')
example_input = File.read('./day2_example_input.txt')


TEST_DATA = '17-32,38-58,3-16'
TEST_DATA_2 = '38593856-38593862'

def part_one(input_str)
    repeated_twice_nums = []
    ranges =  input_str.split(',')
    ranges.each do |range|
        first, last = range.split('-').map(&:to_i)
        range_obj = (first..last)
        range_obj.each do |num|
            num_as_str = num.to_s
            num_length = num_as_str.length
            next if (num_length/2).zero?
            first_half = num_as_str[..(num_length/2) - 1]
            second_half = num_as_str[(num_length/2)..]
            repeated_twice_nums << num if first_half == second_half
        end
    end
    repeated_twice_nums.sum
end

def all_factors(num)
    factors = []
    (1..Math.sqrt(num).to_i).each do |i|
        if (num % i).zero?
            factors << i
            factors << (num / i)
        end
    end
    factors
end

puts part_one(input)

def part_two(input_str)
    repeated_multiple_nums = []
    ranges =  input_str.split(',')
    ranges.map do |range_str|
        first, last = range_str.split('-').map(&:to_i)
        range = (first..last)
        range.each do |num|
            num_str = num.to_s
            num_str_length = num_str.length
            length_factors = all_factors(num_str_length)
            length_factors.delete(num_str_length)

            length_factors.any? do |factor_to_slice_by|
                slice = num_str[0, factor_to_slice_by]
                num_of_slices = num_str_length / factor_to_slice_by
                repeated_multiple_nums << num if slice * num_of_slices == num_str
            end
        end
    end
    repeated_multiple_nums.sum
end

puts part_two(input)


