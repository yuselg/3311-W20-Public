note
	description: "Choices of comparator used by SHOWROOM."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CHOICE[ID -> COMPARABLE, MAKE -> COMPARABLE]

create
	default_create

feature -- Types of comparators

	year: INTEGER
		do
			Result := 0
		ensure
			class
		end

	id: INTEGER
		do
			Result := 1
		ensure
			class
		end

	make: INTEGER
		do
			Result := 2
		ensure
			class
		end

feature -- Queries

	valid_choice (a_choice: INTEGER): BOOLEAN
		do
			Result := a_choice = year or a_choice = id or a_choice = make
		ensure
			class
			correct_result:
				Result = (a_choice = year or a_choice = id or a_choice = make)
		end

	a_comparator (a_choice: INTEGER): KL_COMPARATOR[CAR[ID, MAKE]]
			-- Returns a comparator whose type is consistent with `a_choice`
		require
			valid_choice (a_choice)
		do
			if a_choice = year then
				create {COMPARATOR_BY_YEAR[ID, MAKE]} Result
			elseif a_choice = id then
				create {COMPARATOR_BY_ID[ID, MAKE]} Result
			else
				create {COMPARATOR_BY_MAKE[ID, MAKE]} Result
			end
		ensure
			class
			correct_dynamic_types:
				(a_choice = year implies attached {COMPARATOR_BY_YEAR[ID, MAKE]} Result)
				and
				(a_choice = id implies attached {COMPARATOR_BY_ID[ID, MAKE]} Result)
				and
				(a_choice = make implies attached {COMPARATOR_BY_MAKE[ID, MAKE]} Result)
		end

end
