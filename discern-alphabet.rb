require 'set'

class Alphabet
	
	def initialize()
		@vertices = {}
	end

	def find_first_diff(a, b)
		alen, blen = a.length, b.length
		aptr, bptr = 0, 0
		while a[aptr] == b[bptr] && aptr < alen && bptr < blen
			aptr += 1
			bptr += 1
		end
		
		unless aptr < alen && bptr < blen then
			raise ArgumentError.new("No differences found between #{a} and #{b}.")
		end

		return a[aptr].chr, b[bptr].chr
	end

	def add(first, second)
		f, s = find_first_diff(first.strip, second.strip)

		d = @vertices[s]
		if !d
			@vertices[s] = d = Set.new()
		end	
		if !@vertices.has_key?(f)
			@vertices[f] = Set.new()
		end
		d.add(f)
	end

	def discern
		alphabet = []
		while @vertices.length > 0
			top = @vertices.select { |k, v| v.length == 0 }[0][0]
			alphabet.push(top)
			@vertices.each { |k, v| v.delete(top) }
			s = @vertices.delete(top)
		end
		return alphabet
	end

	def show_vertices
		@vertices.each do |k, v|
			print k, "->"
			v.each { |v2| print v2, " " }
			print "\n"
		end
	end

	def from_file(*args)
		File.open(*args) do |file|
			line_by_line(file)
		end
	end

	def line_by_line(value)
		prev = nil
		value.each do |line|
			cur = line.chomp
			begin
				add(prev, cur) unless prev.nil?
			rescue ArgumentError
				# Just ignore
			end
			prev = cur
		end
	end
end

