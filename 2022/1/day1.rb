# frozen_string_literal: true

def part_one(calories_list)
  max_cals = 0
  current_cals = 0
  calories_list.each do |calorie|
    if calorie.strip.empty?
      max_cals = [max_cals, current_cals].max
      current_cals = 0
    else
      current_cals += calorie.strip.to_i
    end
  end
  max_cals
end

def adjust_cal_tracker(tracker, current_cals)
  tracker.pop
  tracker.append(current_cals)
  tracker.sort.reverse
end

def part_two(calories_list)
  cal_tracker = [0, 0, 0]
  current_cals = 0
  calories_list.each do |line|
    if line.strip.empty?
      cal_tracker = adjust_cal_tracker cal_tracker, current_cals if current_cals > cal_tracker[2]
      current_cals = 0
    else
      current_cals += line.strip.to_i
    end
  end
  cal_tracker.sum
end

input = File.readlines('./day1_inputs.txt')
puts part_one(input)
puts part_two(input)
