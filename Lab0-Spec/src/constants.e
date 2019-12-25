note
	description: "Snooker constants for a table 356.9cm x 177.8cm"
	author: "JSO"

	once_vs_do: "[
	If instead of "do", the implementation of an effective routine 
	starts with the keyword "once", it will only be executed 
	the first time the routine is called. Subsequent calls 
	from the same caller or others will have no effect; 
	if the routine is a function, it will always return 
	the result computed by the first call.
	Below, "once" ensures efficent decimal constants, e.g.
		d: DECIMAL
		d := {CONSTANTS}.width 
	See: eiffel.org and search for "once"
	]"

class
	CONSTANTS
feature
	length: DECIMAL
			-- self initalizing length constant
		once
			Result := "356.9"
		ensure class
		end

	width: DECIMAL
		once
			Result := "177.8"
			ensure class
		end

	zero: DECIMAL
		once
			Result := "0"
		ensure class
		end

invariant
	constants:
		length ~ "356.9" and width ~ "177.8"
	zeroth:
		zero ~ zero.zero

end
