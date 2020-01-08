note
	description: "A person has an id and may have a set of bank accounts"
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
			create accounts.make_empty
			id := a_id
		end

feature -- queries

	id: ID -- identity of this person

	name: detachable STRING

	accounts: ARRAY [ACCOUNT]

	is_equal (other: like Current): BOOLEAN
		do
			Result := id ~ other.id and name ~ other.name
		ensure then
			Result = (id ~ other.id and name ~ other.name)
		end

feature {BANK} -- command

	add_account (a_account: ACCOUNT)
			-- add a new `a_account` for this person
		require
			not accounts.has (a_account)
		do
			accounts.force (a_account, accounts.count +1)
		ensure
			accounts.has (a_account)
			id = old id
		end

	add_name(a_name: STRING)
		do
			name := a_name
		end

feature -- out

	out: STRING
		do
			if attached name as l_name then
				Result := "pid " + id.out + "," + l_name
			else
				Result := "pid" + id.out
			end
		end

	debug_output: STRING
		do
			Result := out
		end

invariant
	id >= 1

end
