input = File.readlines('./day1_input.txt')
example_input = File.readlines('./day1_example_input.txt')

left_ids = []
right_ids = []

input.each do |location_ids|
  left_id, right_id = location_ids.split
  left_ids << left_id.to_i
  right_ids << right_id.to_i
end

def part_one(left_ids, right_ids)
  sorted_left_ids = left_ids.sort
  sorted_right_ids = right_ids.sort

  total_distance = 0
  sorted_left_ids.each_with_index do |l_id, idx|
    right_id = sorted_right_ids[idx]
    distance = (right_id - l_id).abs
    total_distance += distance
  end

  total_distance
end

def part_two(left_ids, right_ids)
  left_tallies = left_ids.tally
  right_tallies = right_ids.tally(Hash.new(0))

  total_similarity_score = 0
  left_tallies.each do |id, id_occurence_count|
    similarity_score = (right_tallies[id] * id) * id_occurence_count
    total_similarity_score += similarity_score
  end
  total_similarity_score
end

puts(part_one(left_ids, right_ids))
puts(part_two(left_ids, right_ids))