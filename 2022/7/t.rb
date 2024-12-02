# frozen_string_literal: true

def rot13(message)
  alphabet = ('a'..'z').to_a
  rotated_alpha = alphabet.rotate(13)
  message.chars.map do |char|
    next char unless char.match?(/[[:alpha:]]/)

    i = alphabet.find_index(char.downcase)
    char.match?(/[[:upper:]]/) ? rotated_alpha[i].upcase : rotated_alpha[i]
  end.join
end

def letter?(char)
  char.match?(/[[:alpha:]]/)
end

def upper_case?(char)
  char.match?(/[[:upper:]]/)
end
