input = File.readlines('./day2_input.txt')
example_input = File.readlines('./day2_example_input.txt')

def increasing?(arr)
  arr.each_cons(2).all? {|num1, num2| (num2 - num1).positive? }
end

def decreasing?(arr)
  arr.each_cons(2).all? {|num1, num2| (num2 - num1).negative? }
end

def at_most_3?(arr)
  arr.each_cons(2).all? {|num1, num2| (num2 - num1).abs <= 3}
end

def safe?(arr)
  (increasing?(arr) || decreasing?(arr)) && at_most_3?(arr)
end

def part_one(input)
  safe_reports = 0
  input.each do |report|
    report_arr = report.split.map(&:to_i)
    safe_reports += 1 if safe?(report_arr)
  end
  safe_reports
end

def part_two(input)
  safe_reports = 0
  input.each do |report|
    report_arr = report.split.map(&:to_i)
    if safe?(report_arr)
      safe_reports += 1
    else
      modified_reports = []
      (0..report_arr.length - 1).each do |idx|
        modified_report = report_arr.dup
        modified_report.delete_at(idx)
        modified_reports << modified_report
      end
      safe_reports += 1 if modified_reports.any?{ |mod_rep| safe?(mod_rep) }
    end
  end
end


