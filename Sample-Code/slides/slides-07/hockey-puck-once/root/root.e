note
	description: "Hockey Game with Shared Puck"
	date: "$Date$"
	revision: "$Revision$"

class
	ROOT

create
	make

feature {NONE} -- Initialization



	make
		local
			h1, h2: HOCKEY_PLAYER
		do
			io.new_line
			create h1.make ("H1")
			create h2.make ("H2")
			h1.hit
			h2.hit
			h2.hit
		end

end

-- Goal: fix code so we get;
--puck count: 0
--puck count: 1; H1 has hit
--puck count: 2; H2 has hit
--puck count: 3; H2 has hit
