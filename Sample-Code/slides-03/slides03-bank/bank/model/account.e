note
	description: "[
		An account has a query balance, owner and account id, 
		and commands to deposit and withdraw exported to BANK.
		balances must be non-negative
	]"
	author: "JSO"
	date: "2020-01-05"

class
	ACCOUNT

inherit

	DEBUG_OUTPUT
		redefine
			 out
			,is_equal
		end
create
	make

feature {NONE} -- Initialization

	make (a_person: PERSON; a_id: ID)
			-- create new account for `a_person`
		do
			owner := a_person
			balance := zero
			id := a_id
		end

feature -- queries

	zero: DECIMAL -- static zero
		once
			Result := "0"
		end

	owner: PERSON
			-- of this account

	balance: DECIMAL

	id: ID
		-- account id

	is_equal(other: like Current):BOOLEAN
		do
			Result := id ~ other.id
				and then balance ~ other.balance
				and then owner ~ owner
		end

feature {BANK, ES_TEST} -- commands

	deposit (a_value: DECIMAL)
			-- deposit `a_value` into account
		require
			a_value >= zero
		do
			balance := balance + a_value
		ensure
			balance ~ (old balance + a_value)
			owner ~ old owner
			id ~ old id
		end

	withdraw (a_value: DECIMAL)
			-- withdraw `a_value` into account
		require
			a_value > zero
			balance - a_value >= zero
		do
--			owner := create {PERSON}.make(2) -- violates post
--			id := create {ID}.make (100)
			
			balance := balance - a_value
		ensure
			balance ~ (old balance - a_value)
			owner ~ old owner
			id ~ old id
		end

feature -- out

	out: STRING
			-- owner:balance,id
		do
			Result := owner.out + ":" + balance.out + "," + id.out
		end

	debug_output: STRING
		do
			Result := out
		end

invariant
	non_negative:
		balance >= zero

end
