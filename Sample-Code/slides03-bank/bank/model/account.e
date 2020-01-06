note
	description: "[
		An account has a query balance, and commands
		to deposit and withdraw exported to BANK.
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

	make (a_person: PERSON)
			-- create new account for `a_person`
		do
			owner := a_person
			balance := zero
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
			-- owner's immutable id
		do
			Result := owner.id
		ensure
			Result = owner.id
		end

	is_equal(other: like Current):BOOLEAN
		do
			Result := id ~ other.id and then balance ~ other.balance
		end

feature {BANK, ES_TEST} -- commands

	deposit (a_value: DECIMAL)
			-- deposit `a_value` into account
		require
			a_value >= zero
		do
			balance := balance + a_value
		ensure
			balance ~ old balance + a_value
			owner ~ old owner
		end

	withdraw (a_value: DECIMAL)
			-- withdraw `a_value` into account
		require
			a_value > zero
			balance - a_value >= zero
		do
			balance := balance - a_value
		ensure
			balance ~ old balance - a_value
			owner ~ old owner
		end

feature -- out

	out: STRING
		do
			Result := id.out + "," + balance.out
		end

	debug_output: STRING
		do
			Result := out
		end

invariant
	non_negative:
		balance >= zero

end
