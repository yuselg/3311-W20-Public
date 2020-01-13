note
	description: "[
		Test examples with arrays and regular expressions.
		First test fails as Result is False by default.
		Write your own tests.
		Included libraries:
			base and extension
			Espec unit testing
			Mathmodels
			Gobo structures
			Gobo regular expressions
		]"
	author: "JSO"
	date: "$Date$"
	revision: "$Revision 19.05$"

class
	TEST_SEARCHING

inherit

	ES_TEST

create
	make

feature {NONE} -- Initialization

	make
			-- run tests
		do
			add_boolean_case (agent t0)
			add_boolean_case (agent t1)
		end

feature -- tests

	t0: BOOLEAN
		local
			a: ARRAY[INTEGER]
			target: INTEGER
			index: INTEGER
		do
			comment ("t0: test INT array with/without target")
				-- this test will fail because Result = False
			target := 632
			a := <<-10, 23, 42, 632, 633, 634>>
			index := {SEARCHING[INTEGER]}.binary_seach (a, target)
			Result := index = 4 and a[4] = 632
			check Result end
			target := 635
			index := {SEARCHING[INTEGER]}.binary_seach (a, target)
			Result := index = 0 -- no target
			check Result end
			target := 100
			index := {SEARCHING[INTEGER]}.binary_seach (a, target)
			Result := index = 0 -- no target
			check Result end
			target := -100
			index := {SEARCHING[INTEGER]}.binary_seach (a, target)
			Result := index = 0 -- no target
			check Result end
		end

	t1: BOOLEAN
		local
			a: ARRAY[STRING]
			target: STRING
			index: INTEGER
		do
			comment ("t1: test STRING array for target a string")
				-- this test will fail because Result = False
			target := "c"
			a := <<"a", "b", "c", "e">>
			index := {SEARCHING[STRING]}.binary_seach (a, target)
			Result := index = 3 and a[3] ~ "c"
			check Result end
		end



end
