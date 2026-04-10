def palindrome?(string)
  answer = string.downcase
  answer = answer.gsub(/\W/, "")
  answer == answer.reverse
end

def count_words(string)
  words = string.downcase.scan(/\b[\w]+/)
  words.each_with_object(Hash.new(0)) { 
    |word, counts| counts[word] += 1 
  }
end

if __FILE__ == $PROGRAM_NAME
  puts palindrome?("A man, a plan, a canal -- Panama")
  puts palindrome?("Madam, I'm Adam!")
  puts palindrome?("Abracadabra")

  puts count_words("A man, a plan, a canal -- Panama")
  puts count_words("Madam, I'm Adam!")
  puts count_words("Abracadabra")
end