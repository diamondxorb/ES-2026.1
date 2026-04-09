def count_words(string)
  words = string.downcase.scan(/\b[\w]+/)
  words.each_with_object(Hash.new(0)) { 
    |word, counts| counts[word] += 1 
  }
end

if __FILE__ == $PROGRAM_NAME
  puts count_words("A man, a plan, a canal -- Panama")
  puts count_words("Madam, I'm Adam!")
  puts count_words("Abracadabra")
end