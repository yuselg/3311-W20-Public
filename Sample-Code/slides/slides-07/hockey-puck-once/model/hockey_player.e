note
	description: "Summary description for {PLAYER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	HOCKEY_PLAYER
inherit
	ANY
		redefine out end
create
	make

feature{NONE}

	make(a_name:STRING)
		do
			name := a_name
		end
feature
	name: STRING


	puck: PUCK
			-- a puck
		do -- fix this to share
			create Result
		end

	hit
		do
			puck.strike
			print(name + " has hit%N")
		end

	out: STRING
		do
			Result := name
		end
invariant
--	inv1: puck = puck

end
