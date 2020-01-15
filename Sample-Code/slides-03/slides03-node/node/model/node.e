note
	description: "Summary description for {NODE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class NODE[G] create
	make

feature {NONE} -- Initialization

	make(a_item: G)
			-- Constructor
		do
			item := a_item
		end

feature -- queries
	item: G
	left, right: detachable NODE[G]

feature -- commands
	set_left(a_node: like Current)
		do
			left := a_node
		end

	set_right(a_node: like Current)
		do
			right := a_node
		end
end
