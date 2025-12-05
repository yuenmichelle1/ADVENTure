example_input = File.read('./day5_example_input.txt')
input = File.read('./day5_input.txt')

def part_one(input)
    id_ranges = []
    avail_ids = []
    fresh_count = 0

    input.split.each do |line|
        if line.include?('-')
            lower, upper = line.split('-').map(&:to_i)
            id_ranges << (lower..upper)
        else
            avail_ids << line&.to_i
        end
    end

    avail_ids.each do |i|
        fresh_count += 1 if id_ranges.any? { |id_range| id_range.include?(i) }
    end
    fresh_count
end

# puts part_one(example_input)

## PART 2

lower_bounds = []
upper_bounds = []
input.split.each do |line|
    if line.include?('-')
        lower, upper = line.split('-').map(&:to_i)
        lower_bounds << lower
        upper_bounds << upper
    end
end

lower_bounds = lower_bounds.sort
upper_bounds = upper_bounds.sort
new_lowers = []
new_uppers = []
lower_bounds.each_with_index do |lower, i|
    if new_lowers.empty?
        new_lowers << lower
    else
        recent_upper = new_uppers[-1]
        # replace upper bound of new upper tracker, if there is an overlap
        if lower <= recent_upper
            new_uppers.pop
        else
            new_lowers << lower
        end
    end
    new_uppers << upper_bounds[i]
end

distances = 0
new_lowers.each_with_index do |lower, i|
    # add 1 to distance because these ranges are inclusive of the bounds
    distances += (new_uppers[i] - lower + 1)
end
puts distances





