example_input = File.open('./day5_example_input.txt').read

rules = example_input.split("\n\n")[0].split("\n")
page_updates = example_input.split("\n\n")[1].split("\n")

# left => [what should be on the right]
before_rules_hash = {}
# right => [ what should be on the left]
after_rules_hash = {}
rules.each do |rule|
    rule_arr = rule.split('|')
    left_side = rule_arr[0]
    right_side = rule_arr[1]
    left_side_rules = before_rules_hash[left_side] || []
    right_side_rules = after_rules_hash[right_side] || []

    left_side_rules << right_side
    before_rules_hash[left_side] = left_side_rules

    right_side_rules << left_side
    after_rules_hash[right_side] = right_side_rules
end

correctly_ordered_pages_centers = []

def check_rules_valid(pages, rules_hash, valid)
    half_way_index = (pages.length / 2).to_f.ceil

    pages.each_with_index do |page, i|
        break if i == half_way_index || !valid

        rules = rules_hash[page]

        ((i + 1)..half_way_index).each do |idx|
            valid &&= (rules.nil? || rules.include?(pages[idx]))
        end
    end
    valid
end

incorrectly_ordered_updates = []

page_updates.each do |page_update|
    valid = true
    pages = page_update.split(',')
    valid = check_rules_valid(pages, before_rules_hash, valid)
    valid = check_rules_valid(pages.reverse, after_rules_hash, valid)

    if valid
        correctly_ordered_pages_centers << pages[(pages.length / 2).to_f.ceil]
    else
        incorrectly_ordered_updates << page_update
    end
end

# puts "PART 1"
# puts correctly_ordered_pages_centers.map(&:to_i).reduce(:+)

# puts "INCORRECTS"
# incorrect_eg_arr = incorrectly_ordered_updates[2].split(',')

# corrected_update = []
# popped_elements = []

# def can_append_to_correct?(before_rules_hash, after_rules_hash, proposed_page, current_last)
#     return true if (before_rules_hash[current_last].nil? && after_rules_hash[current_last].nil?) || (before_rules_hash[current_last]&.include? proposed_page)

#     false
# end

# # puts incorrect_eg_arr
# incorrect_eg_arr.each do |page|
#   if corrected_update.empty?
#     corrected_update << page
#   else
#     # check last element of corrected_update
#     current_last_el_of_corrected = corrected_update[-1]
#     if can_append_to_correct?(before_rules_hash, after_rules_hash, page, current_last_el_of_corrected)
#         corrected_update << page
#     else
#        popped_elements.append(corrected_update.pop)
#     end

#   end
# end

# puts corrected_update