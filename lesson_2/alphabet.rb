#задание 4
# define vowels array
vowels = ['A', 'E', 'I', 'O', 'U', 'Y']
# define empty Hash
vowel_hash = {}
# find the number of vowels in the alphabet
('A'..'Z').each_with_index { |letter, index| vowel_hash[letter] = index + 1 if vowels.include?(letter) }

puts vowel_hash
