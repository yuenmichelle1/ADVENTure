# frozen_string_literal: true

def part_one(games)
  sum_of_possible_game_ids = 0
  games.each do |game|
    game_id = game.split(':')[0].split('Game')[1].strip.to_i
    game_draws = game.split(':')[1].split(';')
    sum_of_possible_game_ids += game_id if possible_game?(game_draws)
  end
  sum_of_possible_game_ids
end

def possible_game?(draws)
  possible = true
  draws.each do |draw|
    cubes_drawn = draw.split(',')
    cubes_drawn.each do |cubes|
      number = cubes.split(' ')[0].to_i
      color = cubes.split(' ')[1]
      return false if number > BAG_CONTENTS[color.to_sym]
    end
  end
  possible
end

def part_two(games)
  sum_of_smallest_possible_product = 0
  games.each do |game|
    game_draws = game.split(':')[1].split(';')
    sum_of_smallest_possible_product += smallest_possible(game_draws).values.reduce(:*)
  end
  sum_of_smallest_possible_product
end

def smallest_possible(draws)
  smallest_possible_cubes = Hash.new(0)
  draws.each do |draw|
    cubes_drawn = draw.split(',')
    cubes_drawn.each do |cubes|
      number = cubes.split(' ')[0].to_i
      color = cubes.split(' ')[1].to_sym
      smallest_possible_cubes[color] = number if number > smallest_possible_cubes[color]
    end
  end
  smallest_possible_cubes
end

BAG_CONTENTS = {
  'red': 12,
  'green': 13,
  'blue': 14
}.freeze

input = File.readlines('./day2_input.txt')
puts('PART ONE')
puts(part_one(input))
puts('PART TWO')
puts(part_two(input))
