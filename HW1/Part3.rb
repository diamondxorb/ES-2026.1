def combine_anagrams(words)
  words.group_by { |word| word.downcase.chars.sort.join }.values

end

if __FILE__ == $PROGRAM_NAME
  input = ["cars", "for", "potatoes", "racs", "four", "scar", "creams", "scream"]
  puts combine_anagrams(input).inspect

end