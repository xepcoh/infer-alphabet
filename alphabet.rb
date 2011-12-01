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
		
		raise ArgumentError.new("No differences found between #{a} and #{b}.") if aptr >= alen || bptr >= blen

		return a[aptr].chr, b[bptr].chr
	end

	def add(first, second)
		f, s = find_first_diff(first.strip, second.strip)

		d = @vertices[s]
		@vertices[s] = d = Set.new() if !d
		@vertices[f] = Set.new() if !@vertices.has_key?(f)
		d.add(f)
	end

	def deduce
		alphabet = []
		while @vertices.length > 0
			selected = @vertices.select { |k, v| v.length == 0 }
			raise "Could not find first element.  Possible causes include file not being sorted or the set of words is insufficient for deducing the alphabet." if selected.length == 0
			top = selected[0][0]
			alphabet.push(top)
			@vertices.each { |k, v| v.delete(top) }
			@vertices.delete(top)
		end
		return alphabet
	end

	def from_file(*args)
		File.open(*args) { |file| line_by_line(file) }
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

