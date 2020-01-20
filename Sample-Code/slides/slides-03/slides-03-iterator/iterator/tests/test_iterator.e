note
	description: "[
		Tests to show use of iterator
		]"
	author: "JSO"

class TEST_ITERATOR inherit
	ES_TEST
		redefine setup end
create
	make

feature {NONE} -- Initialization

	make
			-- run tests
		do
			create a.make_empty
			create az.make_empty
			add_boolean_case (agent t1)

		end

feature -- setup
	a, az: ARRAY [CHARACTER]
	temp: CHARACTER
	j: INTEGER

	setup -- infrastructure for all tests 
		do
			a := <<'a', 'b', 'z', 'd', 'e'>>
			a.compare_objects
				-- the domain of array `a` is 1..3
			check  a [1] = 'a' and a.count = 5 end
			a.put ('c', 3) -- replace a[3]
			az := <<'a', 'b', 'c', 'd', 'e'>>
			az.compare_objects
		end

feature -- test
	t1: BOOLEAN
		do
			comment ("t1: test array of chars")
			-- setup
			assert_equal ("array without z",  az, a)
			-- ∀ is `all`
			Result := across a as cursor all
				cursor.item <= 'e'
			end
			check Result end
			-- is as opposed to as (item)
			Result := across a is a_char all
				a_char <= 'e'
			end
			check Result end
			-- ∃ is `some`
			Result := across a is a_char some
				a_char = 'e'
			end
			check Result end
			-- reverse array a with a loop
			az := <<'e', 'd', 'c', 'b', 'a'>>
			az.compare_objects
			j := a.upper
			across 1 |..| a.count is i loop
				if i < j then -- swap
					temp := a[i]
					a[i] := a[j]
					a[j] := temp
					j := j - 1
				end

			end
			assert_equal ("array with z",  az, a)
		end



end
