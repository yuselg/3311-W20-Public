note
	description: "A collection class with only three elements"
	author: "JSO"
	date: "$Date$"
	revision: "$Revision$"

class GROUP [G -> attached ANY] inherit
	ITERABLE [G]
		undefine
			out
		end
	DEBUG_OUTPUT
		redefine
			out
		end
create
	make
feature {NONE}
	make (a_x, a_y, a_z: G)
		do
			x := a_x
			y := a_y
			z := a_z
		end
feature  -- items over which to iterates
	x, y, z: G

feature -- iterable
	new_cursor: ITERATION_CURSOR [G]
		do
			-- callback to current
			create {ITERATION_CURSOR_GROUP [G]}
				Result.make (Current)
		end

feature -- out
	out: STRING
		do
			Result := "(" +
				x.out + "," +
				y.out + "," +
				z.out + ")"
		end

	debug_output: STRING
		do
			Result := out
		end
end
