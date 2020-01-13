note
	description: "Searching routines including binary search"
	author: "JSO"
	date: "2020-01-12$"
	revision: "$Revision$"

class
	SEARCHING[G -> COMPARABLE]

feature

	binary_seach(a: ARRAY[G]; target: G): INTEGER
		require
			lower:
				a.lower = 1
			sorted:
				across 1 |..| (a.count-1) is i all
				a[i] <= a[i+1]
			end
		local
			p, q: INTEGER -- pivots
			mid: INTEGER -- middle
			found: BOOLEAN
		do
			a.compare_objects
			from
				p := 1
				q := a.count
				Result := 0
			until
				p > q or found
			loop
				mid := (p+q) // 2
				if a[mid] > target then
					q := mid - 1
				elseif
					a[mid] < target
				then
					p := mid + 1
				else -- p = q
					check a[mid] ~ target end
					found := True
					Result := mid
				end
			end
		ensure class  -- pure function
			target_found:
				not a.has (target) implies (Result = 0)
			traget_not_found:
				a.has (target) implies (a[Result] ~target)
		end

end
