# frozen_string_literal: true

ALPHABET = ('a'..'z').to_a
# a - z score 1 - 26
# A - Z score 27 - 52
def calculate_priority(item)
  if ALPHABET.index(item).nil?
    ALPHABET.index(item.downcase) + 27
  else
    ALPHABET.index(item) + 1
  end
end

def part_one(all_rucksacks)
  score = 0
  all_rucksacks.each do |rucksack|
    first_compartment = rucksack[0...(rucksack.length / 2)].split('')
    second_compartment = rucksack[(rucksack.length / 2)...rucksack.length].split('')
    similar_item = (first_compartment & second_compartment)[0]
    score += calculate_priority(similar_item)
  end

  puts score
end

def part_two(all_rucksacks)
  score = 0
  all_rucksacks = all_rucksacks.map { |rucksack| rucksack.split('') }
  elves_bags_split_in_groups = all_rucksacks.each_slice(3).to_a
  elves_bags_split_in_groups.each do |group|
    badge = (group[0] & group[1] & group[2])[0]
    score += calculate_priority(badge)
  end

  puts score
end

part_one(File.readlines('./input.txt'))
part_two(File.readlines('./input.txt'))
