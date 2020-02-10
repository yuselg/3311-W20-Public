note
	description: "[
		Illustrate the difference between reference
		and expanded semantics.
		A CAR has-a BRAND (reference, sharing)
		A CAR has-a ENGINE (expanded, value semantics, no sharing).
		An expanded class 
		(1) must have a default_create without any arguments,
		(2) An assignment e2 := e1 is a copy, not and attachment.
		]"
	date: "$Date$"
	revision: "$Revision$"

class ROOT create
	make

feature {NONE} -- constructor

	make
			-- test reference class BRAND
			-- and expanded class ENGINE
		local
			c1,c2: CAR
			b1,b2: BRAND --reference
			e1,e2: ENGINE --expanded
		do
			comment("create references")
			create b1.make ("Bentley")
			b2 := b1
			comment("expanded does not need a create (default_create)")
			e1.put (300,"AWD") -- expanded
			e2 := e1
			comment("create cars")
			create c1.make (2016, b1, e1)
			create c2.make (2016, b2, e2)

			check c1 /= c2 and b1 = b2 and e1 = e2 end
			print("%NNo contract violations")

			comment("Note that cars c1 and c2 have their own engine")
			comment("Cars c1 and c2 share a brand (they are both Bentleys")
		end

	comment(s:STRING)
		do end
end
