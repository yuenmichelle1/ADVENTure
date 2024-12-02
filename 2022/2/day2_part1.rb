# frozen_string_literal: true

WINNING_CONDITIONS = {
  'rock' => 'scissors',
  'paper' => 'rock',
  'scissors' => 'paper'
}.freeze

score = 0
elf_hand_code = {
  'A' => 'rock',
  'B' => 'paper',
  'C' => 'scissors'
}
my_hand_code = {
  'X' => 'rock',
  'Y' => 'paper',
  'Z' => 'scissors'
}

hand_points = {
  'rock' => 1,
  'paper' => 2,
  'scissors' => 3
}

def calculate_win_loss_score(my_hand, elf_hand)
  win_loss_score = 0
  if WINNING_CONDITIONS[my_hand] == elf_hand
    win_loss_score = 6
  elsif my_hand == elf_hand
    win_loss_score = 3
  end
  win_loss_score
end

File.open('./day2_input.txt').each_line do |line|
  round = line.split(' ')
  elf_hand_symbol, my_hand_symbol = round
  my_hand = my_hand_code[my_hand_symbol]
  elf_hand = elf_hand_code[elf_hand_symbol]
  score += calculate_win_loss_score(my_hand, elf_hand)
  score += hand_points[my_hand]
end

puts score
