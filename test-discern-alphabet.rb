require 'discern-alphabet'
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

	def test_display
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

		assert(a.build == %w(a b c d e f g), "Bad alphabet")
	end

end
