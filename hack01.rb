
def input
	user_input = gets.chomp
	user_input
end

def is_input_valid?(input_string)
	if input_string =~ /\d/ or input_string =~ /\s/
		false
	elsif input_string.length < 2 or input_string.length > 7
		false
	else
		true
	end
end

puts "Enter a string no less than 2 letters and no more than 7 letters.."
user_input = input
while !is_input_valid?(user_input)
	puts "Not a valid input. Enter again"
	user_input = input
end
sorted_user_input = user_input.chars.sort { |a, b| a.casecmp(b) } .join

words_hash = {}

File.open('wordsEn.txt','r').each_line do |line|
	word = line.split(/\t/)
	sorted_word = word[0].chomp.chars.sort { |a, b| a.casecmp(b) } .join
	words_hash[word[0].chomp] = sorted_word
end

sorted_hash = words_hash.sort.to_h

output_array = []

puts "Output"

if sorted_user_input.include?('a')
	output_array.push('a')
end

output_array.push(sorted_hash.select{|k,v| v == sorted_user_input }.map{|i| i[0] })

temp = sorted_user_input.split('')

sorted_user_input.split('').each_with_index do |i,index|
	s = ""
	for j in 0..user_input.length-1
		if j != index
			s += sorted_user_input[j]
		end
	end
	output_array.push(sorted_hash.select{|k,v| v == s }.map{|i| i[0] })
end

puts output_array.flatten.sort