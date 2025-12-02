example_input = File.readlines('./day1_example_input.txt')
input = File.readlines('./day1_input.txt')


def part_one(rotaton_directions)
    zeros_counter = 0
    starting_pos = 50

    rotaton_directions.each do |rotation|
        direction, rotate = rotation.split(/(\d+)/)

        if direction == 'L'
            starting_pos -= rotate.to_i
        else
            starting_pos += rotate.to_i
        end

        zeros_counter += 1 if (starting_pos % 100).zero?
    end
    zeros_counter
end


def part_two(rotation_directions)
    zeros_passed_counter = 0
    current_pos = 50

    rotation_directions.each do |rotation|
        direction, rotate = rotation.split(/(\d+)/)

        old_pos = current_pos % 100
        zeros_passed_counter += (rotate.to_i / 100).floor
        rotate = rotate.to_i % 100

        if direction == 'L'
            current_pos = old_pos - rotate
        else
            current_pos = old_pos + rotate
        end

        zeros_passed_counter += 1 if (old_pos.zero? || current_pos < 0 || current_pos > 100)
    end
    zeros_passed_counter
end

puts part_two(input)