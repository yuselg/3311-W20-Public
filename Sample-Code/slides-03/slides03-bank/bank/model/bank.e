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
			--could use across, but we wish to illustrate a loop
			from i := account_array.lower
			until i > account_array.upper
			loop
				Result := Result + account_array[i].balance
				i := i + 1
			variant account_array.count + 1 - i
			end
		ensure -- Result = (Σa ∈ account.range: a)
			Result >= zero
			Result ~ sum(account.range)
		end

feature -- query helper
	sum(collection: ITERABLE[ACCOUNT]): DECIMAL
			-- return sum of all account balances in `collection`
		do
			Result := "0"
			across collection is it loop
				Result := Result + it.balance
			end
		ensure class
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
			v > zero
			account.has ([p, a]) -- [p, a] ∈ account
		do
			-- precondition ensures that account exists in system
			check attached get_account (p, a) as l_account then
				l_account.deposit(v)
			end
		ensure
			persons_unchanged:
				persons ~ old persons.deep_twin
			other_accounts_unchanged: -- range subtraction
				(account @>> a) ~ old (account.deep_twin @>> a)
			this_account_change:
				a.balance ~ old a.balance + v
			in_account:
				account[p].has (a)
			get_account_correctly_implemented:
				get_account (p, a) ~ a
		end

	withdraw (p: PERSON; a: ACCOUNT; v: DECIMAL)
			-- withdraw amount `v` for person `p` in account `a`
		require
			v > zero
			a.balance - v >= zero
			account.has ([p, a]) -- [p, a] ∈ account
		do
			-- precondition ensures that account exists in system
			check attached get_account (p, a) as l_account then
				l_account.withdraw(v)
			end
		ensure
			persons_unchanged:
				persons ~ old persons.deep_twin
			other_accounts_unchanged: -- range subtraction
				(account @>> a) ~ old (account.deep_twin @>> a)
			this_account_change:
				a.balance ~ old a.balance - v
			in_account:
				account[p].has (a)
			get_account_correctly_implemented:
				get_account (p, a) ~ a
		end

feature{NONE} -- implementation

		get_account(p: PERSON; a: ACCOUNT): detachable ACCOUNT
			-- get account value-equal to `a` for person `p'
			-- in relation `account` if it exists
		local
			l_array: ARRAY[ACCOUNT]
			la: ACCOUNT
			i: INTEGER
			stop: BOOLEAN
		do
			if  account.has ([p, a]) then
				l_array := account[p].as_array
				from i := l_array.lower
				until i > l_array.upper or stop
				loop
					if a ~ l_array[i] then
						Result := l_array[i]
						stop := True
					end
					i := i + 1
				end
			end
		end

invariant
	consistent_persons_and_account:
		across account.domain is p all
			persons.has (p)
		end

	alternative_consistent: -- alternative to subset1
		account.domain |<: persons -- is subset of

	all_persons_have_ids:
		persons ~ id.domain

	unique_ids: id.is_injection


end
