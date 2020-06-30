note
	description: "Summary description for {SORTING}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SORTING[ID  -> COMPARABLE, MAKE -> attached ANY]
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

feature

--	sorted:  ARRAY[CAR[ID, MAKE]]

	sort(a_array: ARRAY [CAR[ID, MAKE]]; a_comparator: like comparator): ARRAY[CAR[ID, MAKE]]
			-- sort cars by id comparator
		local
			l_sorter: DS_ARRAY_QUICK_SORTER [CAR[ID, MAKE]]
		do
			Result := a_array.deep_twin
			comparator := a_comparator
			create l_sorter.make (comparator)
			l_sorter.sort (Result)
--			is_sorted := True
--		ensure
--			sorted: -- ∀i ∈ 1..n: Result[i].year ≤ Result[i+1].year, where n = Result.count-1
--				is_sorted
		end

	search
		do

		end
end
