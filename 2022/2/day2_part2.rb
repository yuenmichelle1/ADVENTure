# frozen_string_literal: true

WINNING_CONDITIONS = {
  'rock' => 'scissors',
  'paper' => 'rock',
  'scissors' => 'paper'
}.freeze

ELF_HAND_CODE = {
  'A' => 'rock',
  'B' => 'paper',
  'C' => 'scissors'
}.freeze

MY_RESULT_CODE = {
  'X' => 0,
  'Y' => 3,
  'Z' => 6
}.freeze

HAND_POINTS = {
  'rock' => 1,
  'paper' => 2,
  'scissors' => 3
}.freeze

def my_hand(my_win_loss_points, elf_hand)
  case my_win_loss_points
  when 6
    WINNING_CONDITIONS.invert[elf_hand]
  when 3
    elf_hand
  else
    WINNING_CONDITIONS[elf_hand]
  end
end

score = 0
File.open('./day2_input.txt').each_line do |line|
  round = line.split(' ')
  elf_hand_symbol, my_result_symbol = round
  elf_hand = ELF_HAND_CODE[elf_hand_symbol]
  my_win_loss_points = MY_RESULT_CODE[my_result_symbol]
  score += my_win_loss_points
  score += HAND_POINTS[my_hand(my_win_loss_points, elf_hand)]
end

puts score
