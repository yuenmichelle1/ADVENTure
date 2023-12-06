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
    first_number_occurrence(amended_calibration) * 10 + last_number_occurrence(amended_calibration)
  end
  actual_calibrations.reduce { |sum, calibration| sum + calibration }
end

def first_number_occurrence(calibration_code)
  first_number = nil
  idx = 0
  while first_number.nil?
    if numeric?(calibration_code[idx])
      first_number = calibration_code[idx].to_i
    else
      first_number = numeric_word_in_string(calibration_code[0, idx + 1])
      idx += 1
    end
  end
  first_number
end

def last_number_occurrence(calibration_code)
  last_number = nil
  idx = calibration_code.length - 1
  while last_number.nil?
    if numeric?(calibration_code[idx])
      last_number = calibration_code[idx].to_i
    else
      last_number = numeric_word_in_string(calibration_code[idx, calibration_code.length - 1])
      idx -= 1
    end
  end
  last_number
end

def numeric_word_in_string(str)
  DIGITS.each_pair do |word, d|
    return d if str.include? word.to_s
  end
  nil
end

def numeric?(look_ahead)
  look_ahead.match?(/[[:digit:]]/)
end

input = File.readlines('./day1_input.txt')
puts('PART ONE')
puts(part_one(input))
puts('PART TWO')
puts(part_two(input))
