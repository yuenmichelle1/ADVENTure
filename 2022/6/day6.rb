# frozen_string_literal: true

input = File.read('./input.txt')

def find_idx_where_uniq(input, chunk_size)
  input.chars.each_cons(chunk_size).with_index do |chars_arr, i|
    return i + chunk_size if chars_arr.uniq.length == chunk_size
  end
end

def part_one(input)
  find_idx_where_uniq(input, 4)
end

def part_two(input)
  find_idx_where_uniq(input, 14)
end

puts part_one(input)
puts part_two(input)
