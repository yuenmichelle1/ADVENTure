# frozen_string_literal: true

def pair_ranges(pair)
  pair.split(',').map do |section|
    start, finish = section.split('-').map(&:to_i)
    Range.new(start, finish)
  end
end

def part_one(all_pairs)
  all_pairs.count do |pair|
    elf_one_range, elf_two_range = pair_ranges pair
    elf_one_range.cover?(elf_two_range) || elf_two_range.cover?(elf_one_range)
  end
end

def part_two(all_pairs)
  all_pairs.count do |pair|
    elf_one_range, elf_two_range = pair_ranges pair
    elf_one_range.cover?(elf_two_range.first) || elf_two_range.cover?(elf_one_range.first)
  end
end

puts part_one(File.readlines('./input.txt'))
puts part_two(File.readlines('./input.txt'))
