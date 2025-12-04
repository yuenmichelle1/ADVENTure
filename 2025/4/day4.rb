require 'matrix'
require 'debug'
example_input = File.readlines('./day4_example_input.txt')
input = File.readlines('./day4_input.txt')

input_arr = input.map { |str_line| str_line.gsub("\n", '').chars }


input_matrix = Matrix[*input_arr]
indices_to_replace_with_dots = []

def part_one(grid, indices_of_accessible)
    accessible_count = 0

    grid.each_with_index do |val, row_idx, col_idx|
        if val == '@'
            ats_around_counter = 0

            # left
            ats_around_counter += 1 if grid[row_idx, col_idx - 1] == '@' && (col_idx - 1) >= 0
            # right
            ats_around_counter += 1 if grid[row_idx, col_idx + 1] == '@' &&  (col_idx + 1) <  grid.column_count
            # top
            ats_around_counter += 1 if grid[row_idx - 1, col_idx] == '@' && (row_idx - 1) >= 0
            # top left
            ats_around_counter += 1 if grid[row_idx - 1, col_idx - 1] == '@' && (row_idx - 1) >= 0 && (col_idx - 1) >= 0
            #top right
            ats_around_counter += 1 if grid[row_idx - 1, col_idx + 1] == '@' && (row_idx - 1) >= 0 && (col_idx + 1) < grid.column_count
            # bottom
            ats_around_counter += 1 if grid[row_idx + 1, col_idx] == '@' && row_idx + 1 < grid.row_count
            # bottom left
            ats_around_counter += 1 if grid[row_idx + 1, col_idx - 1] == '@' && row_idx + 1 < grid.row_count && col_idx - 1 >= 0
            # bottom right
            ats_around_counter += 1 if grid[row_idx + 1, col_idx + 1] == '@' && row_idx + 1 < grid.row_count && col_idx + 1 < grid.column_count

            if ats_around_counter < 4
                accessible_count += 1
                indices_of_accessible << [row_idx, col_idx]
            end
        end
    end
    accessible_count
end


# PART TWO
# debugger
removal_total = 0
to_be_removed_count = part_one(input_matrix, indices_to_replace_with_dots)
puts to_be_removed_count
until to_be_removed_count <= 0
    removal_total += to_be_removed_count
    indices_to_replace_with_dots.each do |row_i, col_i|
        input_matrix[row_i, col_i] = '.'
    end
    indices_to_replace_with_dots = []
    to_be_removed_count = part_one(input_matrix, indices_to_replace_with_dots)
end
puts removal_total
