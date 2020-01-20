note
	description: "[
		Immutable integer identities 
		starting at 1
		]"
	author: "JSO"
	date: "2020-01-05"

class
	ID
inherit
	DEBUG_OUTPUT
		redefine out end

create
	make

convert -- see usage at the end of the class
    make ({INTEGER}),
    id: {INTEGER}

feature {NONE} -- private constructor

	make(a_id: INTEGER)
			-- create a positive identity `a_id`
		require
			is_positive:
				a_id >= 1
		do
			id := a_id
		ensure
			id = a_id
		end
feature
	id: INTEGER

feature -- out
	out: STRING
		do
			Result := id.out
		end

	debug_output: STRING
		do
			Result := out
		end
invariant
	positive: id >= 1
note
	usage: "[
		id: ID
		id := 4
		-- due to convert keyword
		create joe.make (5)
	]"
end
