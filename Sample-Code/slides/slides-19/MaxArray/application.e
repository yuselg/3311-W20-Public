note
	description : "max_array_invariant application root class"
	date        : "$Date$"
	revision    : "$Revision$"

class
	APPLICATION

inherit
	ARGUMENTS
	ES_TEST

create
	make

feature {NONE} -- Initialization

	make
		local

		do
--			add_boolean_case (agent t0)
			add_boolean_case (agent t1)
			add_boolean_case (agent t2)
			add_boolean_case (agent t3)
			add_boolean_case (agent t4)
			show_browser
			run_espec
		end

feature -- tests
	t0: BOOLEAN
		local
			a: ARRAY[REAL]
			ma: MAX_ARRAY
			m: REAL
		do
			comment("t3: max2 routine with array 2.1, 3.8, 2.9")
			a := <<2.1, 3.8, 2.9>>
			create ma
			m := ma.max_in_array3 (a)
			Result := m = 3.8
		end

	t1: BOOLEAN
		local
			a: ARRAY[REAL]
			ma: MAX_ARRAY
			m: REAL
		do
			comment("t1: max1 routine with array 2.1, 3.8, 2.9")
			a := <<2.1, 3.8, 2.9>>
			create ma
			m := ma.max_in_array1 (a)
			Result := m = 3.8
		end

	t2: BOOLEAN
		local
			a: ARRAY[REAL]
			ma: MAX_ARRAY
			m: REAL
		do
			comment("t2: max1 routine with empty array")
			a := <<>>
			create ma
			m := ma.max_in_array1 (a)
			Result := m = 0
		end

	t3: BOOLEAN
		local
			a: ARRAY[REAL]
			ma: MAX_ARRAY
			m: REAL
		do
			comment("t3: max2 routine with array 2.1, 3.8, 2.9")
			a := <<2.1, 3.8, 2.9>>
			create ma
			m := ma.max_in_array2 (a)
			Result := m = 3.8
		end

	t4: BOOLEAN
		local
			a: ARRAY[REAL]
			ma: MAX_ARRAY
			m: REAL
		do
			comment("t4: max2 routine with empty array")
			a := <<>>
			create ma
			m := ma.max_in_array2 (a)
			Result := m = m.negative_infinity
		end

--	t5: BOOLEAN
--		local
--			a: detachable ARRAY[REAL]
--			ma: MAX_ARRAY
--			m: REAL
--		do
--			comment("t4: max2 routine with empty array")
--			create ma
--			m := ma.max_in_array2 (a)
--			Result := m = m.negative_infinity
--		end

end
