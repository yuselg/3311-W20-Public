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
			add_boolean_case (agent t1)
		end

feature -- tests
	t0: BOOLEAN
		do
			comment("t0: First test")
		end

	t1: BOOLEAN
		local
			t: TAX_PAYER
			st: SWISS_TAX_PAYER
			ut: US_TAX_PAYER
			sut: SWISS_US_TAX_PAYER
		do
			create ut.make ("Washington", 1)
			Result := ut.id = 1
			check Result end
			create st.make ("Zurich", -1)
			Result := st.id = -1
			check Result end
			create sut.make ("Swiss-US", 250)
			Result := sut.us_id = 250 and sut.swiss_id = 0
			check Result end
			t := sut
			Result := t.id = 250
		end

end
