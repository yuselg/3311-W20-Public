note
	description: "Root class to test iterator for GROUP"
	date: "$Date$"
	revision: "$Revision$"

class ROOT create
	make

feature {NONE} -- constructor

	g: GROUP[REAL]

	make
			-- Run application
		local
			b: BOOLEAN
		do
			print("%NStart iterator tests ...%N")
			print("--as--%N")
			create g.make(1.1, 2.2, 3.3)

			-- all
			b := across g as cr all cr.item >= 2.3 end
			check not b end -- should succeed

			--some
			b := across g as cr some cr.item >= 2.3 end
			check b end

			-- loop
			across g as cr loop
				print(cr.item.out)
				io.new_line
			end

			-- is
			print("--is--%N")
			across g is r loop
				print(r.out)
				io.new_line
			end

			print("Iterator tests succeeded%N")
		end
end

