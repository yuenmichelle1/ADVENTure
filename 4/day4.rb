# frozen_string_literal: true

def part_one(scratchcards)
  total_points = 0
  scratchcards.each do |scatchcard_comparison|
    card = scatchcard_comparison.split(':')[1]
    winning_numbers = card.split('|')[0].split(' ').map(&:to_i)
    your_card_numbers = card.split('|')[1].split(' ').map(&:to_i)
    matches = winning_numbers.intersection(your_card_numbers).length
    next unless matches.positive?

    points_earned = 1
    points_earned = 2**(matches - 1) if matches > 1
    total_points += points_earned
  end
  total_points
end

def part_two(scratchcards)
  copy_count_hash = Hash.new(0)
  start_index = 0
  while start_index < scratchcards.length
    card = scratchcards[start_index].split(':')[1]
    winning_numbers = card.split('|')[0].split(' ').map(&:to_i)
    your_card_numbers = card.split('|')[1].split(' ').map(&:to_i)
    matches = winning_numbers.intersection(your_card_numbers).length
    copy_count_hash[start_index] += 1
    matches.times do |i|
      start_copy_count_index = start_index + i + 1
      copy_count_hash[start_copy_count_index] += copy_count_hash[start_index]
    end
    start_index += 1
  end
  copy_count_hash.values.sum
end

input = File.readlines('./day4_input.txt')
puts part_one(input)
puts part_two(input)
