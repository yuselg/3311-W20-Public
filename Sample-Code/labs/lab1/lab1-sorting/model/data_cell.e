note
	description: "A generic data cell which stores comparable items."
	author: "Jackie Wang"
	date: "$Date$"
	revision: "$Revision$"

class
	DATA_CELL[G -> COMPARABLE]

create
	make

feature -- Commands
	make (g: G)
		do
			item := g
		end

feature -- Queries
	item: G

end
