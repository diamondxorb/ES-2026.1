def palindrome?(string)
  answer = string.downcase
  answer = answer.gsub(/\W/, "")
  answer == answer.reverse
end

if __FILE__ == $PROGRAM_NAME
  puts palindrome?("A man, a plan, a canal -- Panama")
  puts palindrome?("Madam, I'm Adam!")
  puts palindrome?("Abracadabra")
end