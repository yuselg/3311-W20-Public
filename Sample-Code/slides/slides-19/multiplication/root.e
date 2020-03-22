note
	description: "[
	log(b) algorthim to multiply two numbers a and b.
	This is better than the naive linear in b algorithm.
	Tight bound is 2*log2(y) + odd(y)
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	ROOT

inherit
	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			r :INTEGER
		do
			--| Add your code here


			check even(0) and not odd(0) end
			check not even(1) and odd(1) end
			check even(2) and not odd(2) end
			check not even(3) and odd(3) end

			check  q(4,3) = 12 end

			check q(4,5) = 20 end

			r := q(4, 5)

			print ("%NAll ok!%N")
		end

feature -- mystery query

	even(a_y:INTEGER): BOOLEAN
		do
			Result := a_y \\ 2 = 0
		ensure
			Result = (a_y \\ 2 = 0)
		end

	odd (a_y:INTEGER): BOOLEAN
		do
			Result := a_y \\ 2 /= 0
		ensure
			Result = (a_y \\ 2 /= 0)
		end

	q(a, b: INTEGER): INTEGER
			-- Result is `a' multiplied by `b'
		require
			b >= 0
		local
			x, y, z: INTEGER
		do
			from
				x := a; y := b; z := 0
			invariant
				y >= 0
				z + x*y = a*b
			until
--				not (y > 0 and even(y)) and not odd(y)
				y = 0
			loop
				if y > 0 and even(y) then
					y := y // 2; x := x + x
				else
					check odd(y) end
					y := y - 1; z := z + x
				end
			variant
				y
			end
			Result := z
		ensure
			Result = a*b
		end

end
