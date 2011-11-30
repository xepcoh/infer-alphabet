require 'alphabet'

a = Alphabet.new
a.from_file("./alphabet.txt", "r")
i = 1
a.deduce.each do |letter| 
	puts "Letter #{i} is #{letter}"
	i += 1
end
