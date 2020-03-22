note
	description: "Summary description for {TUPLE1}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TUPLE1
create
	make
feature
	make
		local
			sd: detachable STRING
		do
			t1 := [42, "Robinson"]
--			t1 := [42, sd] -- VJAR error not compatible
			t2 := [42, sd]
		end
feature
	t1: TUPLE[id: INTEGER; name: STRING]

	t2: TUPLE[id: INTEGER; name: detachable STRING]

feature
	div (b, c: INTEGER): TUPLE [INTEGER, INTEGER]
        -- illustration of multi-functions
        -- (two return values) using tuples
        -- b divided by c yields quotient q and remainder r
        -- b = c*q + r, 0 <= r < b
    require
        c /= 0
    local
        r, q: INTEGER
    do
        q := b // c  -- quotient, i.e. integer division
        r := b \\ c	 -- b mod c, i.e. remainder
        Result := [q, r]
    end

end
