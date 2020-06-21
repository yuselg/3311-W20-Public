note
	description: "[
		Run unit tests for Euclid's gcd.
		test t3 exhastively checks correctnes of the algorithm
		against a set theoretic specifcation. 
		Illustrates how DbC can be used to write specfication tests.
		For large numbers use finalized system:
			time F_code/euclid
	]"
	author: "JSO"

class
	ROOT

inherit

	ES_TEST -- unit testing via ESpec

create
	make

feature {NONE} -- Initialization

	make
			-- Run app
		do
			add_boolean_case (agent t0)
			add_boolean_case (agent t1)
			add_boolean_case (agent t2)
			show_browser
			run_espec
		end


feature -- tests

	t0: BOOLEAN
		local
			euclid: EUCLID
			divisors: SET[INTEGER]
		do
			comment ("t0: Check {EUCLID}.divisors(12) = 1, 2, 3, 4, 6, 12")
			create euclid
			divisors := euclid.divisors (12)
			Result := divisors.out ~ "{ 1, 2, 3, 4, 6, 12 }"
----			assert_equal ("divisors error","{ 1, 2, 3, 4, 6, 12 }" , divisors.out)
		end


	t1: BOOLEAN
		local
			euclid: EUCLID
			gcd: INTEGER
		do
			comment ("t1: {EUCLID}.gcd (111, 259) = 37")
				-- this test will fail because Result = False
			create euclid
			gcd := euclid.gcd (111, 259)
			Result := gcd = 37
--			assert_equal ("gcd error", 37, gcd)
		end


	t2: BOOLEAN
		local
			euclid: EUCLID
			gcd, gcd_spec: INTEGER
			k: INTEGER -- iterations
		do
			comment ("t3: exhaustive testing of gcd over 30 x 30")
				-- this test will fail because Result = False
			k := 30 -- use finalized for larger sets
			create euclid
			across 1 |..| k is m loop
			across 1 |..| k is n loop
				gcd := euclid.gcd (m, n)
				gcd_spec := euclid.gcd_spec (m, n)
				-- specification tests
 				Result := gcd = gcd_spec
 				check Result end
-- 				print(m.out + "," + n.out + ": gcd(m,n)= "+ gcd.out + "%N")

 			end
 			end
 			sub_comment ("50 x 50: 4.0s workbench vs. 0.1s finalized ")
 			sub_comment ("200 x 200: 1.1s finalized")
		end

end
