example_input = File.readlines('./day3_example_input.txt')
input = File.readlines('./day3_input.txt')

## PART ONE

max_joltages = []
input.each do |battery|
    battery_joltages = battery.strip.chars.map(&:to_i)
    largest_idx = 0
    battery_joltages.each_with_index do |num, i|
        largest_idx = i if num > battery_joltages[largest_idx] &&  i != (battery_joltages.length - 1)
    end
    second_largest_num = battery_joltages[largest_idx + 1, battery_joltages.length - 1].max
    max_joltages << 10 * battery_joltages[largest_idx] + second_largest_num
end

puts "PART ONE"
puts max_joltages.sum


## PART TWO

TEST_DATA = ['818181911112111', '234234234234278']

largest_joltages = []
input.each do |battery|
    twelve_indexes = {}
    battery_joltages = battery.strip.chars.map(&:to_i)
    joltage = 0
    (0..11).each do |n|
        if n == 0
            twelve_indexes[0] = 0
            # slice the array from index 0 to the max index so that we can still make a 12-digit number with the remainder
            first_joltages = battery_joltages[0..(battery_joltages.length - 12)]
            first_joltages.each_with_index do |battery_val, i|
                twelve_indexes[0] = i  if battery_val > battery_joltages[twelve_indexes[0]]
            end
        else
            # set the initial val as the next index of the previous key
            twelve_indexes[n] = twelve_indexes[n - 1] + 1
            # slice the array to only look at the values that can get us a sequence of twelve at the end with the remainder that is left
            n_joltages = battery_joltages[twelve_indexes[n]..(battery_joltages.length - (12 - n))]

            n_joltages.each_with_index do |battery_val, i|
                twelve_indexes[n] = i + twelve_indexes[n-1] + 1 if battery_val > battery_joltages[twelve_indexes[n]]
            end
        end
        joltage += 10 ** (11 - n) * battery_joltages[twelve_indexes[n]]
    end
    largest_joltages << joltage
end

puts "PART TWO"
puts largest_joltages.sum

# 2342 34234234278
# 23 4 23 4234234278