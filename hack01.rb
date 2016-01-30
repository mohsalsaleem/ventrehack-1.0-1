def input
	user_input = gets.chomp
	user_input.downcase
end

def is_input_valid?(input_string)

	special = "?<>',?[]}{=-)(*&^%$#`~{}."
	regex = /[#{special.gsub(/./){|char| "\\#{char}"}}]/

	#Check for presence of numbers or whitespaces or specialcharacters 
	if input_string =~ /\d/ or input_string =~ /\s/ or input_string =~ regex 
		false

	#Check for length constraint 
	elsif input_string.length < 2 or input_string.length > 7
		false
	else
		#otherwise 
		true 
	end
end

def sort_string(string)
	string.chars.sort { |a, b| a.casecmp(b) }.join
end

#Function to contruct the words list into hash with words as keys with alphabetically sorted words as values
def construct_words_hash
	hash = {}
		File.open('wordsEn.txt','r').each_line do |line|
			word = line.split(/\t/)
			sorted_word = sort_string(word[0].chomp)
			hash[word[0].chomp] = sorted_word
		end
	return hash
end

def compute(string)
	sorted_string = sort_string(string)
	words_hash = construct_words_hash
	sorted_hash = words_hash.sort.to_h
	output_array = []
	if sorted_string.include?('a')
		output_array.push('a')
	end
	output_array.push(sorted_hash.select{|k,v| v == sorted_string }.map{|i| i[0] })
	temp = sorted_string.split('')
	sorted_string.split('').each_with_index do |i,index|
		s = ""
		#Go through the hash to find those meaningful words
		for j in 0..string.length-1
			if j != index
				s += sorted_string[j]
				found_words = sorted_hash.select{|k,v| v == s }.map{|i| i[0] }# Will return an array with found words
				output_array.push(found_words)
			end
		end
	end
	return output_array
end

if File.file?('wordsEn.txt') and File.readable?('wordsEn.txt')
	puts "Legal words file found.."
else
	puts "Legal words file not found. Please place it in the same folder as this program and name it to wordsEn.txt . Exiting.."
	exit
end
#User enters the word
puts "Enter a string with length no less than 2 letters and no more than 7 letters.."
user_input = input

#Check for validity of the word
while !is_input_valid?(user_input)
	puts "Not a valid input. Enter again"
	user_input = input
end

puts "You have entered: "+user_input

#Compute the output
output = compute(user_input)
puts "Output: "
puts output.flatten.sort.uniq # Make the recieved array into a single array(flatten),
							  #  sort it, remove dupicates and show the output
