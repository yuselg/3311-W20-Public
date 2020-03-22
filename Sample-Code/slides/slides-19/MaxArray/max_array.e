note
	description: "Summary description for {MAX_ARRAY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MAX_ARRAY
feature


	max_in_array2 (a: ARRAY [REAL]): REAL
		require True
		local
			i: INTEGER
		do
			from
				i := a.lower - 1
				Result := Result.negative_infinity
			invariant
				a.lower-1 <= i and i <= a.upper
				-- ∀j∈ a.lower..i: Result ≥ a[j])
				across a.lower |..| i as j all
					Result >= a[j.item]
				end
				i >= a.lower implies a.has (Result)
				i < a.lower implies Result = Result.negative_infinity
			until
				i = a.upper
			loop
				i := i + 1
				check
					a.lower <= i and i <= a.upper
				end
				Result := Result.max (a [i])
			variant
				a.upper - i
			end
		ensure
			-- ∀j∈ a.lower..a.upper: Result ≥ a[j])
			across a.lower |..| a.upper as j all
					Result >= a[j.item]
				end
			a.lower <= a.upper implies a.has (Result)
			a.lower > a.upper implies Result = Result.negative_infinity
		end

	max_in_array1 (a: ARRAY [REAL]): REAL
		local
			i: INTEGER
		do
			from
				i := a.lower
				Result := a[a.lower]
			until
				i = a.upper
			loop
				i := i + 1
				Result := Result.max (a [i])
			end
		ensure
			-- ∀j∈ a.lower..a.upper: Result ≥ a[j])
			one: across a.lower |..| a.upper as j all
					Result >= a[j.item]
				end
			two: a.has (Result)
		end


	max_in_array3 (a: ARRAY [REAL]): REAL
		require True
		local
			i: INTEGER
		do
			from
				i := a.lower-1
				Result := Result.negative_infinity
			invariant
				a.lower-1 <= i and i <= a.upper
				-- ∀j∈ a.lower..i: Result ≥ a[j])
				across a.lower |..| i as j all
					Result >= a[j.item]
				end
				i >= a.lower implies a.has (Result)
				i < a.lower implies Result = Result.negative_infinity
			until
				i = a.upper
			loop
				if i < 1 then i := i + 1 end
--				check
--					a.lower <= i and i <= a.upper
--				end
				Result := Result.max (a [i])
			variant
				a.upper - i
			end
		ensure
			-- ∀j∈ a.lower..a.upper: Result ≥ a[j])
			across a.lower |..| a.upper as j all
					Result >= a[j.item]
				end
			a.has (Result)
		end

end
