note
	description: "Summary description for {TEST_AGENT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_AGENT
inherit
	ES_TEST
create
	make
feature
	make
		do
			add_boolean_case (agent test_function_do_something)
			add_boolean_case (agent test_counting)
		end

feature -- tests
	test_function_do_something	: BOOLEAN
			local
				-- f1: FUNCTION[TUPLE[BOOLEAN,INTEGER],REAL_64]
				f1: FUNCTION[BOOLEAN,INTEGER,REAL_64]
				f2: FUNCTION[INTEGER, REAL_64]
				f3: FUNCTION[REAL_64]
				r1, r2, r3: REAL_64
			do
				-- store functions, but don't execute them
				f1 := agent do_something(?, ?)     -- two open args
				f2 := agent do_something (true, ?) -- one open arg
				f3 := agent do_something (false, 7)

				-- above is not executed until what follows

				r1 := f1(true, 7)  -- f3.item ([true, 7])
				Result := 2.333 <= r1 and r1 <= 2.334
				check Result end

				r2 := f2(7)
				Result := 2.333 <= r2 and r2 <= 2.334
				check Result end

				r3 := f3.item
				Result := r3 = 0  -- default value
				check Result end

			end


	do_something (flag: BOOLEAN; x: INTEGER) : REAL_64
			-- Return x/3 if `flag’ holds true
 		do
   			if flag then
		   		Result := x/3
		   	end
		end

	do_something2 (x: INTEGER) : REAL_64
 		do
   			Result := do_something (true, x)
		end

	test_function_do_something2: BOOLEAN
			local
				-- f1: FUNCTION[TUPLE[BOOLEAN,INTEGER],REAL_64]
				f1: FUNCTION[BOOLEAN,INTEGER,REAL_64]
				r: REAL_64
			do
				-- stores function, but don't execute it
				f1 := agent do_something(?, ?)    -- two open args

				-- above is not executed until what follows
				r := f1(true, 9) -- f1.call ([true,7]); r := f1.last_result

				Result := r = 3
			end

	gt(r:REAL): BOOLEAN
		do
			Result := r >= 4.0
		end

	test_counting: BOOLEAN
		local
			a: ARRAY[REAL]
			p: PREDICATE[REAL]
		do
			comment("test_counting: with an array")
			a := <<1.2, 3.9, 8.3, 16>>

			Result := {COUNTING}.number_of(a, agent gt) = 2
		end
end
