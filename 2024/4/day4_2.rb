# frozen_string_literal: true

input = File.readlines('./day4_input.txt')
input_arr = input.map { |str_line| str_line.delete("\n").chars }

def m_s_across?(l, r)
  (l == 'M' && r == 'S') || (l == 'S' && r == 'M')
end

def is_x_mas?(a_row, a_column, input_arr)
  m_or_s =  %w[M S]
  directions = [
    [a_row - 1, a_column - 1], # top_left
    [a_row + 1, a_column + 1], # bottom_right
    [a_row + 1, a_column - 1], # top_right
    [a_row - 1, a_column + 1]  # bottom_left
  ]

  return false unless directions.all? do |row, col|
    m_or_s.include?(input_arr[row][col])
  end

  m_s_across?(input_arr[directions[0][0]][directions[0][1]], input_arr[directions[1][0]][directions[1][1]]) &&
    m_s_across?(input_arr[directions[2][0]][directions[2][1]], input_arr[directions[3][0]][directions[3][1]])
end

def part_two(input_arr)
  counter = 0
  input_arr.each_with_index do |line_chars, row|
    next if row.zero? || row == line_chars.length - 1

    line_chars.each_with_index do |line_char, column|
      next if line_char != 'A' || column.zero? || column == line_char.length - 1

      counter += 1 if is_x_mas?(row, column, input_arr)
    end
  end
  counter
end

puts part_two(input_arr)
