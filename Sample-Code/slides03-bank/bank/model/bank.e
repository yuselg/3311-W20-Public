note
	description: "[
		A bank consisting of a set of accounts for persons.
		New persons, and new accounts for a person
		can be added.
		Can deposit/withdraw from accounts
		Total of mone in the bank can be calculated.
	]"
	author: "JSO"
	date: "2020-01-05"

class
	BANK

create
	make

feature {NONE} -- Initialization

	make
			-- create initial empty bank
		do
			create persons.make_empty
			create account.make_empty
			create id.make_empty
		end

feature -- model queries

	zero: DECIMAL
		once
			Result := "0"
		end

	persons: SET [PERSON] -- why not ARRAY[PERSON]?

	account: REL [PERSON, ACCOUNT]
			-- a person can have multiple accounts

	id: FUN [PERSON, ID]
			-- a person has an id


	total: DECIMAL
			-- total money in all accounts in the bank
			-- array implementation and loop
		local
			account_array: ARRAY[ACCOUNT]
			i: INTEGER
		do
			Result := zero
			account_array := account.range.as_array
			from i := account_array.lower
			until i > account_array.upper
			loop
				Result := Result + account_array[i].balance
				i := i + 1
			variant account_array.count + 1 - i
			end
		ensure
			Result >= zero
				-- Result = (Σa ∈ account.range: a)
		end

	total_alternative: DECIMAL
			-- total money in all accounts in the bank
			-- across iteration
		do
			Result := zero
			across
				account.range as l_account
			loop
				Result := Result + l_account.item.balance
			end
		ensure
			Result >= zero
				-- Result = (Σa ∈ account.range: a)
		end

feature -- commands

	add_person (p: PERSON)
			-- add person `p` as a bank customer
		require
			new_person: not persons.has (p)
		do
			persons.extend (p)
			id.extend ([p, p.id])
		ensure
			new_person: persons ~ (old persons.deep_twin + p)
			with_id: id ~ old id.deep_twin + [p, p.id]
			unchanged_account: account ~ old account.deep_twin
			unchanged_total: total ~ old total
		end

	add_account (a: ACCOUNT; p: PERSON)
			-- add account `a` for person `p`
		require
			person_exists: persons.has (p)
			is_new_account: not account.has ([p, a])
		do
			account.extend ([p, a])
		ensure
			unchanged_person: persons ~ old persons.deep_twin
			unchanged_id: id ~ old id.deep_twin
			new_account: account ~ (old account.deep_twin + [p, a])
			unchanged_total: total ~ old total
		end

	deposit (p: PERSON; a: ACCOUNT; v: DECIMAL)
			-- deposit amount `v` for person `p` in account `a`
		require
			persons.has (p) 		-- p ∈ persons
			account [p].has (a) --  p ∈ account[p], relational image
			v > zero
		do
			a.deposit (v)
		ensure
			persons_unchanged:
				persons ~ old persons.deep_twin
			other_accounts_unchanged: -- range subtraction
				(account @>> a) ~ old (account.deep_twin @>> a)
			this_account_change:
				a.balance ~ old a.balance + v
		end

	wihdraw (p: PERSON; a: ACCOUNT; v: DECIMAL)
			-- wihdraw amount `v` for person `p` in account `a`
		require
			persons.has (p) 		-- p ∈ persons
			account [p].has (a)  --  p ∈ account[p], relational image
			v > zero
			a.balance - v >= zero
		do
			a.withdraw (v)
		ensure
			persons_unchanged:
				persons ~ old persons.deep_twin
			other_accounts_unchanged: -- range subtraction
				(account @>> a) ~ old (account.deep_twin @>> a)
			this_account_change:
				a.balance ~ old a.balance - v
		end

invariant
	consistent_persons_and_account:
		across account.domain is p all
			persons.has (p)
		end
	alternative_consistent: -- alternative to subset1
		account.domain |<: persons -- is subset of

	unique_ids: id.is_injection

end
