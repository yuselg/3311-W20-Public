note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_MOVE_BISHOP

inherit
	ETF_MOVE_BISHOP_INTERFACE
		redefine move_bishop end
create
	make
feature -- command
	move_bishop(square: TUPLE[x: INTEGER_64; y: INTEGER_64])
		
    	do

			-- create move op
			-- To Do

			-- push
			etf_cmd_container.on_change.notify ([Current])
    	end

end
