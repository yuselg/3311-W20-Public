note
	description: "Summary description for {COUNTING}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	COUNTING
feature
	number_of (a: ARRAY[REAL]; predicate: FUNCTION [REAL, BOOLEAN]): INTEGER
		    -- Number of  values in a.lower … a.upper
		    -- that satisfy the predicate
		do
			across a as r loop
				if predicate(r.item) then
					Result := Result + 1
				end
			end
		ensure
			class -- makes this query static
		end
end
