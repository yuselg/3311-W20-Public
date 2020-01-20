note
	description: "[
		A person has an id and may have a set of bank accounts
		]"
	author: "JSO"
	date: "2020-01-05"

class
	PERSON

inherit

	ANY
		redefine
			 out
			,is_equal -- equality of persons by id
		end

	DEBUG_OUTPUT
		redefine
			 out
			,is_equal -- equality of persons by id
		end

create
	make

feature {NONE} -- Initialization

	make (a_id: ID)
			-- Initialization for `Current'.
		do
			id := a_id
		ensure
			id = a_id
		end

feature -- queries


	id: ID -- identity of this person


	is_equal (other: like Current): BOOLEAN
		do
			Result := id ~ other.id
		ensure then
			Result = (id ~ other.id)
		end

feature -- out

	out: STRING
		do
			Result := "pid" + id.out
		end

	debug_output: STRING
		do
			Result := out
		end

invariant
	id >= 1
end
