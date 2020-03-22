note
	description: "Summary description for {TESTS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TESTS

inherit

	ES_TEST

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			add_boolean_case (agent t0)
			add_boolean_case (agent test_three_tuple)
			add_boolean_case (agent test_integer_divison)
			add_boolean_case (agent t2)
			add_boolean_case (agent t4)
		end

feature -- tests

	t0: BOOLEAN
		local
			tuple: TUPLE1
		do
			comment ("t0: Test simple tuple")
			create tuple.make
			Result := tuple.t1 [1] = 42 and tuple.t1 [2] ~ "Robinson"
		end

	test_three_tuple: BOOLEAN
		local
			t3: TUPLE [BOOLEAN, INTEGER, STRING]
		do
			comment ("test_three_tuple")
			t3 := [False, 342, "Bzttt!"]
			Result := t3 [1] = False and t3 [2] = 342 and t3 [3] ~ "Bzttt!"
		end

	test_integer_divison: BOOLEAN
			-- Calculate 23/4,
			-- 23 = 5*4 + 3
			-- a  =  q*b + r
		local
			td: TUPLE [INTEGER, INTEGER]
			tuple: TUPLE1
		do
			create tuple.make
			td := tuple.div (23, 4)
			Result := td [1] = 5 and td [2] = 3
				-- 23 = 4*5 + 3
		end

	t2: BOOLEAN
		local
			bar: FOO [STRING]
			cool: TUPLE [s: STRING]
		do
			comment ("t2: test FOO[G] with tuple")
			cool := ["Swaglacious"]
			create bar.make (cool)
			Result := bar.item2 ~ "Swaglacious"
		end

	t4: BOOLEAN
		local
			bar: FOO2 [INTEGER]
			cool: TUPLE [INTEGER]
		do
			comment ("t4: test FOO2[G] with tuple")
			cool := [42]
			create bar.make (cool)
			Result := bar.item = 42
		end

end
