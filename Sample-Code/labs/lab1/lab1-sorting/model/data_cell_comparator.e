note
	description: "A comparator meant to compare data cells which store comparable items"
	author: "Jackie Wang"
	date: "$Date$"
	revision: "$Revision$"

class
	DATA_CELL_COMPARATOR[G -> COMPARABLE]

inherit
	KL_COMPARATOR[DATA_CELL[G]]

feature
	attached_less_than (u, v: DATA_CELL[G]): BOOLEAN
		do
			Result := u.item < v.item
		end
end
