note
	description:	"Support for design by contract in areas where language or compiler is deficient."

class DBC_SUPPORT

feature
	comment( s : STRING ) : BOOLEAN
			-- Return true (because this feature is intended just to
			-- provide a place to write comments in contracts that
			-- the ISE compiler will not lose).
		do
			Result := true
		end


	delta(x,y,e:REAL):BOOLEAN
			-- difference between `x' and `y' to some epsilon `e'
		do
			if x /= 0 then
				Result := (x-y)/x <= e
			else
				Result := (x-y)/(x+.00001) <= e
			end
		end
end


