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
	TEST_NODE

inherit

	ES_TEST

create
	make

feature {NONE} -- Initialization

	make
			-- initialize tests
		do
			add_boolean_case (agent t0)

		end

feature -- tests
	left, right: detachable NODE[STRING]

	t0: BOOLEAN
		local
			node: NODE[STRING]
		do
			comment ("t0: Test node and left link")
			create node.make("middle")
			Result := node.item ~ "middle"
			check Result end
			-- create left node
			create left.make ("left")
			if attached left as l_left then
				Result := l_left.item ~ "left"
			end
		end



end
