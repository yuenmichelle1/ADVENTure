# frozen_string_literal: true

# example_part_1_input = 'xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))'
def part_one(input)
  real_mul_instructions = input.scan(/mul\(\d{1,3},\d{1,3}\)/)
  real_mul_instructions.sum do |instruction|
    instruction.scan(/\d{1,3}/).map(&:to_i).reduce(1, :*)
  end
end

def find_pattern_indices(pattern, input)
  input.enum_for(:scan, pattern).map { Regexp.last_match.offset(0).first }
end

def part_two(input)
  dont_indices = find_pattern_indices(/don't\(\)/, input)
  do_indices = find_pattern_indices(/do\(\)/, input)

  add_to_modified_string = true
  modified_input = input.chars.each_with_index.with_object([]) do |(char, i), arr|
    if dont_indices.include? i
      add_to_modified_string = false
    elsif do_indices.include? i
      add_to_modified_string = true
    end

    arr << char if add_to_modified_string
  end.join
  part_one(modified_input)
end

puts part_one(File.read('./day3_input.txt'))
puts part_two(File.read('./day3_input.txt'))
