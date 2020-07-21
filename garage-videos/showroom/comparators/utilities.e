note
	description: "Searching and sorting utilities"
	author: "Jackie Wang"
	date: "$Date$"
	revision: "$Revision$"

class
	UTILITIES[ID  -> COMPARABLE, MAKE -> COMPARABLE]

create
	make

feature {NONE}

	comparator: KL_COMPARATOR[CAR[ID, MAKE]]

	make
		local
			default_comparator:  COMPARATOR_BY_ID[ID, MAKE]
		do
			create default_comparator
			comparator := default_comparator
		end

feature -- Sorting

	sort(a_array: ARRAY [CAR[ID, MAKE]]; a_comparator: like comparator): ARRAY[CAR[ID, MAKE]]
			-- Sort `a_array` of cars with respect to `<` as defined by `a_comparator`
		local
			l_sorter: DS_ARRAY_QUICK_SORTER [CAR[ID, MAKE]]
		do
			Result := a_array.deep_twin
			comparator := a_comparator
			create l_sorter.make (comparator)
			l_sorter.sort (Result)
		ensure
			consistent_size:
				a_array.count = Result.count

			consistent_contents: -- input `a_array` and ouput `Result` are permutations of each other.
				across a_array is l_c
					all
						a_array.occurrences (l_c) = Result.occurrences (l_c)
					end

			is_sorted: -- ∀i ∈ 1..n: Result[i] < Result[i+1], where n = Result.count-1 and '<' is a partial order defined by `a_comparator`.
				across 1 |..| (Result.count - 1) is i
					all
						a_comparator.less_than (Result[i], Result[i + 1])
					end
		end

feature -- Searching

	search_car (a_array: ARRAY [CAR[ID, MAKE]]; a_car: CAR[ID, MAKE]; a_comparator: like comparator): INTEGER
			-- Return index to `a_array` for car identified by the partial order defined by`a_comparator`
			-- if it exists, otherwise zero.
		require
			is_sorted: -- ∀i ∈ 1..n: a_array[i] < a_array[i+1], where n = a_array.count-1 and '<' is a partial order defined by `a_comparator`.
				across 1 |..| (a_array.count - 1) is i
					all
						a_comparator.less_than (a_array[i], a_array[i + 1])
					end
		local
			p, q: INTEGER -- pivots
			mid: INTEGER  -- middle
			found: BOOLEAN
			an_array: like a_array
		do
			an_array := a_array
			from
				p := 1; q := an_array.count; Result := 0
			invariant
				target_not_found: not found implies
					Result = 0
				target_found: found implies
					p <= Result and Result <= q and a_comparator.attached_order_equal (an_array[Result], a_car)
			until
				p > q or found
			loop
				mid := (p+q) // 2
				if a_comparator.less_than (a_car, an_array[mid])  then
					q := mid - 1
				elseif a_comparator.greater_than (a_car, an_array[mid]) then
					p := mid + 1
				else -- p = q
					check a_comparator.attached_order_equal(an_array[mid], a_car) end
					found := True
					Result := mid
				end
			variant
				(q - p + 1) - (if found then 1 else 0 end)
			end
		ensure  -- pure function
			target_not_found:
				not (across a_array is car some a_comparator.attached_order_equal (car, a_car) end) implies
					(Result = 0)
			target_found:
				(across a_array is car some a_comparator.attached_order_equal (car, a_car) end) implies
					(a_comparator.attached_order_equal(a_array[Result], a_car))
		end
end
