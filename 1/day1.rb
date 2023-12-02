# frozen_string_literal: true

DIGITS = {
  'one': 1,
  'two': 2,
  'three': 3,
  'four': 4,
  'five': 5,
  'six': 6,
  'seven': 7,
  'eight': 8,
  'nine': 9
}.freeze

def part_one(amended_calibration_values)
  actual_calibrations = amended_calibration_values.map do |amended_calibration|
    calibration_nums = amended_calibration.chars.filter { |l| numeric?(l) }
    (calibration_nums.first + calibration_nums.last).to_i
  end
  actual_calibrations.reduce { |sum, calibration| sum + calibration }
end

def part_two(amended_calibration_values)
  actual_calibrations = amended_calibration_values.map do |amended_calibration|
    calibration_from_words(amended_calibration)
  end
  actual_calibrations.reduce { |sum, calibration| sum + calibration }
end

def calibration_from_words(calibration_word)
  nums = []
  index_tracker = {}
  DIGITS.flatten.map(&:to_s).each do |word|
    idx_of_occurence = calibration_word.index(word)
    next if idx_of_occurence.nil?

    ridx_of_occurrence = calibration_word.rindex(word)
    if index_tracker[:first_word_idx].nil? || idx_of_occurence < index_tracker[:first_word_idx]
      index_tracker[:first_word_idx] = idx_of_occurence
      nums[0] = digit_from_word(word)
    end
    if index_tracker[:last_word_idx].nil? || ridx_of_occurrence > index_tracker[:last_word_idx]
      nums[1] = digit_from_word(word)
      index_tracker[:last_word_idx] = ridx_of_occurrence
    end
  end
  nums.first * 10 + nums.last
end

def digit_from_word(word)
  if DIGITS.key?(word.to_sym)
    DIGITS[word.to_sym]
  else
    word.to_i
  end
end

def numeric?(look_ahead)
  look_ahead.match?(/[[:digit:]]/)
end

input = File.readlines('./day1_input.txt')
puts('PART ONE')
puts(part_one(input))
puts('PART TWO')
puts(part_two(input))