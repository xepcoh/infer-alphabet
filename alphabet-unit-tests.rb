require 'alphabet'
require 'test/unit'

class TestAlphabet < Test::Unit::TestCase

	def test_find_first_diff
		a = Alphabet.new

		assert_raise ArgumentError do 
			x, y = a.find_first_diff("a", "a") 
		end

		x, y = a.find_first_diff("b", "c")
		assert(x == "b" && y = "c", "Failed for (b, c)")

		x, y = a.find_first_diff("ab", "ac")
		assert(x == "b" && y = "c", "Failed for (ab, ac)")

		x, y = a.find_first_diff("abce", "abcd")
		assert(x == "e" && y = "d", "Failed for (abce, abcd)")

		x, y = a.find_first_diff("ab", "acd")
		assert(x == "b" && y = "c", "Failed for (ab, acd)")

		x, y = a.find_first_diff("abc", "ad")
		assert(x == "b" && y = "d", "Failed for (abc, ad)")
	end 

	def test_deduce
                p = <<INPUT_END
aa
ab
ac
bc
bd
be
ce
cf
cg
INPUT_END
	
		a = Alphabet.new
		a.line_by_line(p)

		assert(a.deduce == %w(a b c d e f g), "Failed happy path")
	end

	def test_deduce_handles_no_diff
                p = <<INPUT_END
a
ab
ac
ba
INPUT_END
	
		a = Alphabet.new
		a.line_by_line(p)

		assert(a.deduce == %w(a b c), "Failed no diff (proper substring)")

                p = <<INPUT_END
ab
ab
ac
bc
INPUT_END
	
		a = Alphabet.new
		a.line_by_line(p)

		assert(a.deduce == %w(a b c), "Failed no diff (equal length)")
	end

	def test_deduce_sample_input_works
		expected = ["r", "c", "t", "s", "w", "m", "z", "p", "k", "o", "v", "x", "j", "d", "f", "u", "y", "a", "n", "b", "q", "i", "e", "g", "h", "l"]

		alphabet = Alphabet.new
		alphabet.from_file("./alphabet.txt", "r")
		assert(alphabet.deduce == expected, "Failed on sample input")
	end

	def test_deduce_with_garbage
                p = <<INPUT_END
sadf
agfk
kasdf
kasdf
qk
wei
kasd
qier
asdfk
INPUT_END
	
		a = Alphabet.new
		a.line_by_line(p)
		a.deduce
	end
end
