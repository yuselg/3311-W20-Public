note
	description: "[
		Test bank
		]"
	author: "JSO"
	date: "2020-01-05"

class
	TEST_BANK

inherit

	ES_TEST


create
	make

feature {NONE} -- Tests to run

	make
			-- run tests
		do
			add_boolean_case (agent test_id)
			add_boolean_case (agent test_account_equality)
			add_boolean_case (agent t0)
			add_boolean_case (agent t1)
			add_boolean_case (agent t2)

			-- violation cases
			add_violation_case_with_tag ("is_positive", agent violation_test_id)
			add_violation_case_with_tag ("new_person", agent t10)
		end

	zero: DECIMAL
		once
			Result := "0"
		end

	br: STRING = "<br>"


feature -- tests
	test_id: BOOLEAN
		local
			id1, id2, id3: ID
		do
			comment("test_id: test class ID")
			-- create id1
			create id1.make (3)
			Result := id1.id = 3
			check Result end
			-- create id2
			id2 := 6
			Result := id2.id = 6
			check Result end
			Result := id1 /~ id2
			check Result end
			Result := id1 ~ 3 and id2 ~ 6
			check Result end
			id3 := 3
			Result := id1 ~ id3
		end

	test_account_equality: BOOLEAN
		local
			a1, a2: ACCOUNT
			joe: PERSON
		do
			comment ("test_account_equality: test equality of two acounts")
			create joe.make (1)
			create a1.make (joe)
			a1.deposit ("13.04")
			Result := a1.balance ~ "13.04"
			check Result end
			create a2.make (joe)
			a2.deposit ("13.04")
			Result := a1 ~ a2
			check Result end
		end

	t0: BOOLEAN
		local
			joe1, joe2: PERSON
			i1, i2: INTEGER
		do
			comment ("t0: test joe with id 3")
			-- INTEGER is expanded class
			i1 := 3; i2 := 3
			Result := i1 = i2
			-- ID is a reference class
			check Result end
			create joe1.make (3)
			Result := joe1.id ~ 3 and not (joe1.id = 3)
			check Result end
			create joe2.make (3)
			Result := joe1 ~ joe2
			check Result end
		end

	t1: BOOLEAN
		local
			b: BANK
			joe: PERSON
			a: ACCOUNT
		do
			comment ("t1: create joe with account a and test it with deposit/withdraw")

			create b.make
			-- create joe with id=1
			create joe.make (1)
			b.add_person (joe)
			Result := b.persons.has (joe)
			-- create an account for joe
			check Result end
			create a.make (joe)
			b.add_account (a, joe)
			Result := b.account[joe].has (a) and a.balance ~ zero and a.id ~ 1
			b.deposit (joe, a, "20.42")
			Result := b.account[joe].has (a) and a.balance ~ "20.42"
			check Result end
			b.wihdraw (joe, a, "10.42")
			Result := b.account[joe].has (a) and a.balance ~ "10.00"
			check Result end
		end

	t2: BOOLEAN
		local
			b: BANK
			amy, joe: PERSON
			a,j,j2: ACCOUNT
		do
			comment ("t2: create accounts amy (id=1) and joe (id=2) and test them")
				-- this test will fail because Result = False
			create b.make
			-- create amy with id=1
			create amy.make (1)
			b.add_person (amy)
			-- create joe with id=2
			create joe.make (2)
			b.add_person (joe)
			Result := b.persons.has (joe) and b.persons.has(amy)
			check Result end
			create a.make (amy)
			create j.make (joe)
			b.add_account (a, amy)
			b.add_account (j, joe)
			-- amy deposit; withdraw
			Result := b.account[amy].has (a) and a.balance ~ zero and a.id ~ 1
			b.deposit (amy, a, "31.42")
			Result := a.balance ~ "31.42"
			check Result end
			b.wihdraw (amy, a, "11.42")
			Result :=  a.balance ~ "20.00"
			check Result end
			-- joe
			Result := b.account[joe].has (j) and j.balance ~ zero and j.id ~ 2
			b.deposit (joe, j, "20.42")
			Result := j.balance ~ "20.42"
			check Result end
			b.wihdraw (joe, j, "10.42")
			Result := j.balance ~ "10.00"
			check Result end
			Result := b.persons.out ~ "{ id:1, id:2 }"
			check Result end
			Result := b.account.out ~ "{ id:1 -> 1,20.00, id:2 -> 2,10.00 }"
			check Result end
			sub_comment("bank.account: { id:1 -> 1,20.00; id:2 -> 2,10.00 }")
			Result := b.total ~ "30"
			check Result end
			--make another account for joe
			create j2.make (joe)
			b.add_account (j2, joe)
			b.deposit (joe, j2, "5.50")
			Result := b.total ~ "35.50"
			check Result end
			Result := b.account.out ~
				"{ id:1 -> 1,20.00, id:2 -> 2,10.00, id:2 -> 2,5.50 }"
		end


feature -- violation cases
	violation_test_id
		local
			id1, id2: ID
		do
			comment("violation_test_id: ids must be positive")
			create id1.make (-5)
			-- expect precondition failure
		end

	t10
		local
			b: BANK
			joe, amy: PERSON
--			a: ACCOUNT
		do
			comment ("t10: must be unique ids")
				-- this test will fail because Result = False
			create b.make
			-- create amy with id=1
			create amy.make (1)
			b.add_person (amy)
			-- create joe with same id=1
			create joe.make (1)
			b.add_person (joe)
			-- precondition violation in bank.add_person
		end
end
