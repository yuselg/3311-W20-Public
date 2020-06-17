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
	TEST_EXAMPLE

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

	t0: BOOLEAN
		local
			car: CAR[STRING]
		do
			comment ("t0: Test a negative read of odometer")
			create car.make ("Porsche 911 ", 2020, -12)
			Result := car.odometer = -12
		end

end
