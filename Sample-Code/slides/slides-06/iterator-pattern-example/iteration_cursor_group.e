note
	description: "Iteration Cursor for class GROUP"
	author: "JSO"
	date: "$Date$"
	revision: "$Revision$"

class
	ITERATION_CURSOR_GROUP[G -> attached ANY]
inherit
	ITERATION_CURSOR[G]
create
	make
feature {NONE}
	make(a_g: GROUP[G])
			-- an instance of container
		do
			container := a_g
			item := container.x
		end

	container: GROUP[G]

feature -- Access

	item: G

	after: BOOLEAN

	forth
		do
			if item ~ container.x then
				item := container.y
			elseif item ~ container.y then
				item := container.z
			else
				item := container.z
				after := True
			end
		end





end
