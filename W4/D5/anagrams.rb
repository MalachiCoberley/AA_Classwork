def first_anagram?(str1, str2)
  anagrams = str1.split("").permutation(str1.length).to_a
  anagrams.map! { |anagram| anagram.join("") }
  anagrams.include?(str2)
end

def second_anagram?(str1, str2)
  str2_array = str2.split("")
  str1.each_char.with_index do |char, idx|
    idx2 = str2_array.index(char)
    return false if idx2 == nil
    str2_array.delete_at(idx2)
  end
  str2_array.join("") == ""
end


p second_anagram?("cat", "toooooooooooc")